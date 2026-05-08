Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9183D9DDC
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778268189; cv=none; b=sfhVxcvyyqMVXbpeXIA7AXNPPWO3zV0n0k8wQIIIvd141dv9tzaZdcH3o5HCUtPQrBfAACTyJASJTolxBSHfchN97krbUzrZ0Cb8Ma6BN1x7l+Cq+2RI+UpG8FUvEtxSxFlNiY/DlGBhL1sj/gbPwF3XB7FGk9NfWjK45Xe1LS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778268189; c=relaxed/simple;
	bh=y8P21Yzplfhy3t3Rf2N9bH50s1QJi7yYtJ/S/owHu48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M20lcU3XXBAHVOijayLgEy3oxM/4vTV/79MBWi7kbPYUIhyMN9x2eeuXm5URPfZRNcVvjr+TrY8NyqCAVTzfwsTIKyCFEpolhj6+byUEjCusG9rt6uMiq/weYybHv5F5kDqXwZtBtrTBJlJ923NT1o/qw9YtAD0taLFTcUFAXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6gGSJ3G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6gGSJ3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778268186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aK5Dktsy9tqejg2dCHsFdFDrzwNpAxfo7fhjuDwo79E=;
	b=N6gGSJ3GurVFkQpxk7lFQZZZ0LIS2ZDOGrj6G2zpfhbUemIyfx8wlwVdemffXWAlmbLn96
	cX2BN/7nv/qhRQlnU4mjdrvtg9QO/EEfRh5s/9gjYDl0kUgA08/WhXx5jNVx1SNtvf0jSx
	ALIviHsOnHa1Me4F0Xo5T86mofA04H4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-W4H7sPPfMYqSVr4-ejIyZw-1; Fri, 08 May 2026 15:23:05 -0400
X-MC-Unique: W4H7sPPfMYqSVr4-ejIyZw-1
X-Mimecast-MFC-AGG-ID: W4H7sPPfMYqSVr4-ejIyZw_1778268184
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50faf575af4so53694001cf.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 12:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778268184; x=1778872984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK5Dktsy9tqejg2dCHsFdFDrzwNpAxfo7fhjuDwo79E=;
        b=hT0gsL0DL+CurwqVBw+rFLHDu3kvI4ylL+botsxlHBhm/T8vB3wdGoj4IUlEpbNNAk
         9i6Jb+DZf8Ap9qiw4DuWMsWs4Epagh0yJH/VmTnz2YK8nsVd6KCJIuFEDi86+qREC3A1
         iTeNiHiTg1X1ynYwGhJN//bM++TWsHqo1QruAjmiS6GUR2YNvu3ZochYiQCeSyJOeaBH
         uXx7ikgDeYYQVck3XvSkyVI3VefRsUDNXP1m9yxWD1wPjWWzlR87doONEQX2wxT8MMrX
         /vonXlB3IQfivibu+GEVnvIdQNya+1/B7YeiyjhRzT76yR3R2oZJlS6cqlo0k5jcFl9F
         7NbQ==
X-Gm-Message-State: AOJu0Yzv9/fg21ojLBu/Tx3NZ48jkNa8BhIiMEUKpSsCIn2jsjx+Kuj2
	sUr8vs0iAr0V8B8Or1GzVw+/lU2Aj8EPljYIdfygbfzZbkZhNlcqcjkG0zk2nMlrgYlsML9gcNf
	fHkPAHFO5m2YKMxRZDX12S7deQJx16AQWBAy1iwdpOa4W1RDmHj9Qo6Ct
X-Gm-Gg: AeBDieugCXTgDySQZemO8qeyVc1eevb4v2Iels/pEpave4td/hngY7RU3CbEC9d3pFJ
	SxuytwiiwdZ4jmQegMSZ1QKiD5vzgtdQL7MC7KGIaKVC6tkF2lu1xg78JiQDkEqG8PvSbZaAMyD
	u5axQvLslrqFRo+Nvr+9s9Q4wXkUpjDVcNs4gPiAipPRFw/+Tx8XDRxGeZ0pmpev+SYsIFc55vq
	h/riLP3SD5VBuT3oyH9H9SKp/1N2Ce5qcteP6ICoOsu5urGd/yRN61w4SwbohA4yMpqqC1o6b7N
	bo2YE+RVBAPISqfsEnEKaprot0XSQ0X9gUy1g5vLGyoE4TFv/WO6dGWYhIJkzCZUNQyY5CQeRat
	lM6kILuSxcCZsBTVxZZcCX/4=
X-Received: by 2002:ac8:7f8a:0:b0:509:44c3:5ffa with SMTP id d75a77b69052e-51461fd0ea4mr197934271cf.52.1778268184516;
        Fri, 08 May 2026 12:23:04 -0700 (PDT)
X-Received: by 2002:ac8:7f8a:0:b0:509:44c3:5ffa with SMTP id d75a77b69052e-51461fd0ea4mr197933711cf.52.1778268183928;
        Fri, 08 May 2026 12:23:03 -0700 (PDT)
Received: from localhost ([2600:8800:1593:b400:1e8c:ec8f:1337:fb26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bef56sm24533791cf.15.2026.05.08.12.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 12:23:02 -0700 (PDT)
Date: Fri, 8 May 2026 12:23:00 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com, 
	suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	linux-kernel@vger.kernel.org, jgg@ziepe.ca
Subject: Re: [PATCH v5 0/4] Respect VASIZE for address limits
Message-ID: <af41-umpPHen-9Ry@jsnitsel-thinkpadt14sgen2i.remote.csb>
References: <cover.1776075533.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1776075533.git.Ankit.Soni@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XJ-0P48pz2kWqSo6pIIGQAPEU61vmNEjFHTPihCbhk0_1778268184
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2026 at 02:45:17PM +0000, Ankit Soni wrote:
> The AMD IOMMU driver was only using EFR[HATS] to derive the VA size,
> ignoring the IVINFO[VASIZE] limit. This could create domains that
> exceed the bounds advertised by hypervisor. With this series, driver
> respects IVINFO[VASIZE] when determining the addressable VA range.
> 

Should the AMD code also respect IVINFO[PASIZE]? VMWare presents an IVRS
table that has both set to 40 bits.

[000h 0000 004h]                   Signature : "IVRS"    [I/O Virtualization Reporting Structure]
[004h 0004 004h]                Table Length : 000000BC
[008h 0008 001h]                    Revision : 01
[009h 0009 001h]                    Checksum : AD
[00Ah 0010 006h]                      Oem ID : "VMWARE"
[010h 0016 008h]                Oem Table ID : "VMW IVRS"
[018h 0024 004h]                Oem Revision : 06040001
[01Ch 0028 004h]             Asl Compiler ID : "VMW "
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 004h]         Virtualization Info : 00142803
[028h 0040 008h]                    Reserved : 0000000000000000

[030h 0048 001h]               Subtable Type : 11 [Hardware Definition Block (IVHD)]
[031h 0049 001h]       Flags (decoded below) : 00
                                     HtTunEn : 0
                                      PassPW : 0
                                   ResPassPW : 0
                                Isoc Control : 0
                               Iotlb Support : 0
                                    Coherent : 0
                            Prefetch Support : 0
                                 PPR Support : 0
[032h 0050 002h]                      Length : 008C
[034h 0052 002h]                    DeviceId : 0010
[036h 0054 002h]           Capability Offset : 0040
[038h 0056 008h]                Base Address : 00000000FEC10000
[040h 0064 002h]           PCI Segment Group : 0000
[042h 0066 002h]         Virtualization Info : 0000
[044h 0068 004h]                  Attributes : 00000000
[048h 0072 008h]                   EFR Image : 00004000000000C4
[050h 0080 008h]                    Reserved : 0000000000000000

Regards,
Jerry

> For a small VA size, domain initialization in the generic page table
> framework can fail with -EOPNOTSUPP. This happens because the page table
> clears the dynamic top feature from the force enabled feature set, as no
> page table growth is needed beyond the current level.
> This series also fixes this issue and adds KUnit test coverage for the
> 32-bit VA configuration.
> 
> Changes:
> v5: - Added Jason's suggestion for modifying get_info().
> v4: - Remove PT_FEAT_DYNAMIC_TOP check from pt_init_common().
>     - Add test coverage in amdv1 for 32bit va size.
> v3: - Remove specific value checking for vasize.
>     - Add patch for PT_FORCE_ENABLED_FEATURES.
> v2: - Mark ivinfo_vasize_bits() as __init.
> 
> Ankit Soni (4):
>   iommu_pt: Fix pgsize_bitmap calculation in get_info for smaller vasz's
>   iommu_pt: support small VA for AMDv1
>   iommu_pt: add kunit config for 32-bit VA (amdv1_cfg_1)
>   iommu/amd: Adhere to IVINFO[VASIZE] for address limits
> 
>  drivers/iommu/amd/amd_iommu.h               |  2 +-
>  drivers/iommu/amd/amd_iommu_types.h         |  1 +
>  drivers/iommu/amd/init.c                    | 13 +++++++++----
>  drivers/iommu/amd/iommu.c                   |  3 +--
>  drivers/iommu/generic_pt/fmt/amdv1.h        |  1 +
>  drivers/iommu/generic_pt/iommu_pt.h         | 12 ++++++------
>  drivers/iommu/generic_pt/kunit_generic_pt.h | 10 +++++++---
>  drivers/iommu/generic_pt/kunit_iommu_pt.h   |  5 +++--
>  8 files changed, 29 insertions(+), 18 deletions(-)
> 
> -- 
> 2.43.0
> 

