Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9902AE93
	for <iommu@lists.linux.dev>; Tue, 10 Dec 2024 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789866; cv=none; b=t5dXEVYWEeFCHHT06XCUDTcLqbIR5669VszYWiIA7PlBRRNebNj1NRNLwmHWozCbRkWNFpXuCIoe7TgTsCNCEcHi4tBhC7xj9wtkxlRgOOcF2tBSdWa/oWwL7XrEYMgL2o3o0+pmn20OoDEOVSM/N7mNmq7UxNH0aWE0oNZ0r1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789866; c=relaxed/simple;
	bh=m9fdTgvV4om3dTXka47L8D3/RsldfSkBmBd35vDJMKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCl+ILGYv001HKBVpy65JR5hRo/0Venurna+DBZ6xM2j1S1GX+sDgawBY1liWdqlQBIE+F1tN39Z4CpbxuNk6WdFSyiOyO7ozQcFYcA9YR/Gm5nvxLgvXh7cryB1C9EmA1gdwXlQYZqMm3lotzYEemd6pi2HvPeddx4FEQaEALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hze1JZ58; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hze1JZ58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43271C4CEE0;
	Tue, 10 Dec 2024 00:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733789866;
	bh=m9fdTgvV4om3dTXka47L8D3/RsldfSkBmBd35vDJMKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hze1JZ58mEB3ensutbC679+vWUYfV+tGM5hadQFqlr4tFmx5SA6PeMHRasnuiE26y
	 u6pfYrzk5UzFqdeCC/za1RSIdslvwoly9LcVyRG4rxIPb3LbCi694mEdaSUmVcPYCA
	 LsjC9y1JcMnK7pWjCp+TMJyQSGucQuEQqWxgIs5/DCmQk3hTVi0SBHO/XBDzMbKKmq
	 gV7Gh4r5dGAVq4yNhn3iQNOt2FRROD9QkwZBLflByMFeitTncB7Xf4TExsaduigrnh
	 ryVkBosb+r/PF9DWrFWA+Awz6RSPCuwL3iyfgpFzoVakOsxVoMidPm8EGEnpV8ZWxR
	 v4YgboWmEh3sQ==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v6 0/2] iommu/arm-smmu-v3: Parse out event records
Date: Tue, 10 Dec 2024 00:17:29 +0000
Message-Id: <173378062404.4091733.5462540525505481045.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241203184906.2264528-1-praan@google.com>
References: <20241203184906.2264528-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 03 Dec 2024 18:49:04 +0000, Pranjal Shrivastava wrote:
> Enhance the arm-smmu-v3 driver to parse out useful information from
> event records into a structure for better event handling & logging.
> 
> Some sample events, powered by QEMU:
> 
> 1. Bad StreamID:
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
      https://git.kernel.org/will/c/43ca55f5555b
[2/2] iommu/arm-smmu-v3: Log better event records
      https://git.kernel.org/will/c/d814b70b9b90

One thing I noticed when playing around with this on Qemu, however, is
that we print the raw hex dump in reverse compared to the way in which
the record tables are described in the spec. What do you think about
doing something like the following on top of your series?


diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 143ff6336a95..d33a150b29ef 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1880,8 +1880,8 @@ static void arm_smmu_dump_raw_event(struct arm_smmu_device *smmu, u64 *raw,
 
 	dev_err(smmu->dev, "event 0x%02x received:\n", event->id);
 
-	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
-		dev_err(smmu->dev, "\t0x%016llx\n", raw[i]);
+	for (i = EVTQ_ENT_DWORDS - 1; i >= 0; --i)
+		dev_err(smmu->dev, "[%u]\t0x%016llx\n", i, raw[i]);
 }
 
 #define ARM_SMMU_EVT_KNOWN(e)	((e)->id < ARRAY_SIZE(event_str) && event_str[(e)->id])


Then, for example, a permission fault looks like:

[   32.543815] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x13 received:
[   32.545115] arm-smmu-v3 arm-smmu-v3.0.auto: [3]	0x0000000000000000
[   32.546361] arm-smmu-v3 arm-smmu-v3.0.auto: [2]	0x00000000fffff040
[   32.548672] arm-smmu-v3 arm-smmu-v3.0.auto: [1]	0x0000020000000000
[   32.550209] arm-smmu-v3 arm-smmu-v3.0.auto: [0]	0x0000002000000013
[   32.551990] arm-smmu-v3 arm-smmu-v3.0.auto: event: F_PERMISSION client: 0000:00:04.0 sid: 0x20 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
[   32.553952] arm-smmu-v3 arm-smmu-v3.0.auto: unpriv data write s1 "Input address caused fault" stag: 0x0

I started going a step further and printing the records 32 bits at a
time (again, to match the spec), but then I realised that the current
code doesn't look like it handles big-endian properly...

Finally, coccinelle suggests you could use str_read_write() instead of:

	evt->read ? "read" : "write",

which I suppose we could.

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
