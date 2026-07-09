Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC43C2B82;
	Thu,  9 Jul 2026 19:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627116; cv=none; b=nvrnUgYGjbtUdmJNwG3aTdNr/qGMaRHb0HWW2QQhYbHCVfnUROmmk6e7TpKbjPOFSajIvlzpdsALniYCu0XSK+23rtCtMW1L5o7IKO5h0KLuwd5NNqHZOl9EQCCnt26UhOYyYMU+d29ADgbBCsgQ/lUg6JpdkYosNDMoQLIhG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627116; c=relaxed/simple;
	bh=K6rjzbHCVrlWwE2RQoaVtQeAJlFlOsUk1pUi/GjUJ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fHBeb3mOiqizNrwP4IxHP+gefeQVR77dLTqH5fDi/VsB2My//ekRl/9Zm1nVwek4ppIyY6B1nAKHKWbLKw7PvcOSAsl8KU4pcvwE2Yqg7Y7nOXZ1HxuLwMJ5oUsL27wxzAwCplsX+p8zgBbvFIU2pWD/XdQ+Yilxevo8j6fqcvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9oLMXXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9oLMXXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABBD1F000E9;
	Thu,  9 Jul 2026 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783627115;
	bh=0sDNU38URWNnyllr2Q5VvZRH+Tzr3iaQhTgxaDXIaa0=;
	h=From:To:Cc:Subject:Date;
	b=A9oLMXXj+QNTEOhar4l35cqTzmnCSyTFL2Jfs/phn+Ploew0KQSqtm07/1ouPKO56
	 2QJW/CiQ5eEuKwiOgWbEBPvwdZxS3gXAKdXYfSBJT1vBIDSf52GjEIOOHQL9jARCKH
	 WfHqag7s3IPcuAJDvSUwYOfXi6ShU4k16MwDZrfg9rdsYgg5zQSKBcqZPalz+6cYi7
	 5+ZzQCO305AxvmH4hvu9AIWZ6zHiKEU4ovOKTGDcXWzLmkQJSwMje1tEQePzQr/0rV
	 3pCxovRhvnvJ2GA1PpiiRsmG3MN+ODSptkPYkS803vxKJ5jVC1J9BRHhtD08Ywe2db
	 84VX2fK6+D9Vg==
From: Tycho Andersen <tycho@kernel.org>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Tycho Andersen (AMD)" <tycho@kernel.org>
Subject: [PATCH v1 0/2] Fix some nits in nested domain allocation
Date: Thu,  9 Jul 2026 13:57:34 -0600
Message-ID: <20260709195736.3070536-1-tycho@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

Here are a couple of small things I ran across while testing some code.

Thanks,

Tycho

Tycho Andersen (AMD) (2):
  iommu/amd: Fix IRQ unsafe locking in gdom allocation
  iommu/amd: Fix nested domain leak

 drivers/iommu/amd/nested.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0

