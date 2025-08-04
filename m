Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32D1E5B9A;
	Mon,  4 Aug 2025 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322034; cv=none; b=rJCaAfVZiyRz5p8xhP8L9kMpEvu84IBTgBOkUWfABmSzebS/Y+C8j29+SNkC8JVQKnuHmKtLpaF+MdUg5EVznq6fJH2uHPE5undI6PYiaWbc1+K7SOpdR9vO9s0/+slXAfhV9Lo/ou3QEaJZp6ksIGHVrTEOq7kEzNol1RGNRlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322034; c=relaxed/simple;
	bh=b+sFbCBtnYUlyWbizednqxtG2tEDRBQXwNXPOmvYCBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjJOxtbqMoofJrcJJJq4xFzOTOX4qLtnS9qI/Q3tu66Jtq0en+9bJHArAFmTuvxFWeNz7Smsi1aJX9sF5IYYJ6geNucUNigQ/eVEve7qxAr0ZFFE0UWLKdpuUfvkx6WkgkkKmJP2Db30K167iAOrZyBUey9X0umv6ptPLaVYA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTS7lZzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTS7lZzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C0AC4CEE7;
	Mon,  4 Aug 2025 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754322033;
	bh=b+sFbCBtnYUlyWbizednqxtG2tEDRBQXwNXPOmvYCBQ=;
	h=From:To:Cc:Subject:Date:From;
	b=LTS7lZzlMYMr/IRVlHG4wmEmAHztzwQ5Z1jRIgWUn44iKECyPZmKrxLQN5LXhkCqr
	 Jv4uXhWK3lYWmY0Iw3eWiz1KIPXK2RoG79HdwL1crKgW+ENlGHIPFIPJWLWAw7GiYY
	 qFimmIBE1nB1ycpQrQwny9yIdirm5JWDGVh9NP2x3hPEmYCd1oO9SxltbAz5q9m61G
	 KPy7PTxDLnufsB60aXd2TXLJzmXhUaGLPmh1QJQrO4zARI2YnyHGMygu7Cq/ll9f76
	 Vynnrs3kPaP3idlqJuWrhDdaWRpT/UoVQLW5hpGkDrV1B9LBDCxDo7X3ubGy6PJOrp
	 S8+a7p7Acvoaw==
From: Kees Cook <kees@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Kees Cook <kees@kernel.org>,
	Simcha Kosman <simcha.kosman@cyberark.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
	Kim Phillips <kim.phillips@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH RESEND] iommu/amd: Avoid stack buffer overflow from kernel cmdline
Date: Mon,  4 Aug 2025 08:40:27 -0700
Message-Id: <20250804154023.work.970-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=kees@kernel.org; h=from:subject:message-id; bh=b+sFbCBtnYUlyWbizednqxtG2tEDRBQXwNXPOmvYCBQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTrmTvtpGQm6NpYF2c5Tyxt9v/nrS0SsmWT4+OMXrdj 5j5vmJdRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERaJzAy/Hl6zmJahFuV3kq1 SC6htaEyqfmXSrZ3zpA5cEPE1uHYSkaGnerb/lxulPa+UxKh+03lTk2oZtIL3esPdh8M/H2vJvg +BwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While the kernel command line is considered trusted in most environments,
avoid writing 1 byte past the end of "acpiid" if the "str" argument is
maximum length.

Reported-by: Simcha Kosman <simcha.kosman@cyberark.com>
Closes: https://lore.kernel.org/all/AS8P193MB2271C4B24BCEDA31830F37AE84A52@AS8P193MB2271.EURP193.PROD.OUTLOOK.COM
Fixes: b6b26d86c61c ("iommu/amd: Add a length limitation for the ivrs_acpihid command-line parameter")
Signed-off-by: Kees Cook <kees@kernel.org>
---
This was sent out before but it didn't end up on any public mailing list. My mistake!
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: <iommu@lists.linux.dev>
---
 drivers/iommu/amd/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7b5af6176de9..e11322d8d775 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3638,7 +3638,7 @@ static int __init parse_ivrs_acpihid(char *str)
 {
 	u32 seg = 0, bus, dev, fn;
 	char *hid, *uid, *p, *addr;
-	char acpiid[ACPIID_LEN] = {0};
+	char acpiid[ACPIID_LEN + 1] = { }; /* size with NUL terminator */
 	int i;
 
 	addr = strchr(str, '@');
@@ -3664,7 +3664,7 @@ static int __init parse_ivrs_acpihid(char *str)
 	/* We have the '@', make it the terminator to get just the acpiid */
 	*addr++ = 0;
 
-	if (strlen(str) > ACPIID_LEN + 1)
+	if (strlen(str) > ACPIID_LEN)
 		goto not_found;
 
 	if (sscanf(str, "=%s", acpiid) != 1)
-- 
2.34.1

