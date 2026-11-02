Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625725;
	b=WLKvvT/+cGKWlLqWZ4f7EtpqLaPVIHachuuIH1w1Zw6IZv6x3abUAlxi4b+xsI4IBtZa
	 REDkuFeHQ/7l70AERPR47119ia2Ztv3bV7kIz1KkwOnPiCOa0d+5jQ2413MTvIWvsF/Dv
	 7yv2tJ2pKpgWELk4HPeGdBQXRGTFJ84IjuZkRvfI0NxkZiq2Tv+sBWEz8JJevkP0d3sZH
	 EJyM1QXhdHoh8VfnbwFBpFvon6OTeDcXfLTJ+0JSyVAt/eFdiH6oVHDqaxsi9/gvCxMVs
	 Hv8nWSNU1dD9F7mBINHeucFqqoh90QHQ61dxbOMCZkx+5PTpszENqJPmbW3g0ncHngQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625725;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=djgnkC1S9SsBayDDJz8CWP9esVizW3/CZWCKQKY14tA=;
	b=ymmWv2hB9W3TVqQyXvLLe5FoavZCzfUQ8gKV8GtNlDkNM34OzOIRRpRDswjt4aGSTRDi
	 8mZrbmMMNqspA6ppGNpq9jclPWl9dmt0/y4CIuoRpNkU0TUBQ0bF3+qCWxdGpMkm5sjwp
	 8gflN7WnfNPqSRuf8iCuHdro0SWQsAS758MQHqZWt+2G8MdxTH2I8TE7CDyIP+z6ovp4f
	 Swh2H1YnqTsV8w0j6rB1Xt0AUDlu4IJqHTdEjuoH54g1jCyYkjyWuRWQxakbrOZMluxfz
	 cmK/6Mf5Nsm2ZKZPB1fKftiSy33KF26gNjvSz0M/Nar42jkSvlSfFtH+tit2sOmjvtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=s6kooDtb;
	arc=none smtp.remote-ip=115.124.30.130
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87B6606A324
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 13:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C87B6606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=s6kooDtb
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793625720; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=djgnkC1S9SsBayDDJz8CWP9esVizW3/CZWCKQKY14tA=;
	b=s6kooDtbhWXqSHnQktLITnOxeaYS6+V2AtgCwSVH+rVACMXo6lTWsLDFTA4ibP6Y3JVO4D2fLicSBqTn2Lx0+3ShUISE/3EXIxNB4/QgYVG6iGtGFKxUydu6tNxklm7S6so+N2c5Gpw4pcO2aNB/XhBp1PAT2ZRszTDaPTw4W9c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XE-KG9J_1793625716;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XE-KG9J_1793625716 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 21:21:58 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@ziepe.ca
Cc: alex@ghiti.fr,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joerg.roedel@amd.com,
	joro@8bytes.org,
	jroedel@suse.de,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	nutty.liu@hotmail.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tanchi25@mails.ucas.ac.cn,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [PATCH v6 09/10] iommu/riscv: Add dirty tracking support for second-stage domains 
Date: Mon,  2 Nov 2026 21:21:51 +0800
Message-Id: <20261102132151.52507-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261102131356.GA274202@nvidia.com>
References: <20261102131356.GA274202@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> >@@ -1439,6 +1454,9 @@ static int riscv_iommu_init_domain_s2(struct device *dev,
>> > 	if (domain->gscid < 0)
>> > 		return -ENOMEM;
>> >
>> >+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
>> >+		domain->domain.dirty_ops = &riscv_iommu_dirty_ops;
>>
>> This sets dirty_ops based on whether the allocating device's IOMMU
>> supports AMO_HWAD. As I understand it, the domain/HWPT is not tied
>> to that IOMMU instance. A later attach may target a device behind
>> another instance without AMO_HWAD, and the attach can still succeed
>> with GADE disabled, potentially causing guest page faults.
>>
>> Shouldn't we therefore revalidate AMO_HWAD cap for domains with
>> dirty_ops and reject this combination?
>>
>> FYI, both AMD and Intel have attach-time dirty-tracking checks. See
>> drivers/iommu/intel/iommu.c:3195 and drivers/iommu/amd/iommu.c:3221.
>
>Right, need to check on every domain attach that the domain is
>compatible with the iommu instance.
>

Hi Shuai, Jason:

Thanks for pointing that out.

The domain is not tied to the allocating IOMMU instance, and
riscv_iommu_attach_paging_domain() only sets GADE when the target
instance advertises AMO_HWAD. As a result, attaching a dirty-tracking
domain to a device behind an instance without AMO_HWAD would silently
succeed. 
I'll fix this in the next version.

Thanks,
Fangyu

>Jason
