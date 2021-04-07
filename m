Return-Path: <SRS0=DRkM=JE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDD3C433ED
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 18:44:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131C961353
	for <iommu@archiver.kernel.org>; Wed,  7 Apr 2021 18:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131C961353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5AEC84C6D;
	Wed,  7 Apr 2021 18:44:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mjotde_C1csT; Wed,  7 Apr 2021 18:44:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0014D83857;
	Wed,  7 Apr 2021 18:44:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C82E5C000B;
	Wed,  7 Apr 2021 18:44:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB35EC000A
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 18:44:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2FE440406
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 18:44:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1p6ubWRS9GFZ for <iommu@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 18:44:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9DFEE4013F
 for <iommu@lists.linux-foundation.org>; Wed,  7 Apr 2021 18:44:10 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 w203-20020a1c49d40000b029010c706d0642so3008071wma.0
 for <iommu@lists.linux-foundation.org>; Wed, 07 Apr 2021 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=U09jkuhbNd4GqgIa8gbKdPQlfgb0wMDSk0hVwDV1gRw=;
 b=ngd4o4PyyH4y4MwaG4cnoC6BYaNJKVmTUn1FLk6iHOAPaNG8DeUfZzhymKYlRt0WBF
 HGIOklvd6ZH0GhYEpHVm1LuvZ4z2wBSgD26kvfyaBhMfmn663lBk1uddv969zUJdaAYt
 3YBKSHQAb6fT2Vyy/1JMWOttU9895pAjrlIlWnXHy+8Vp2NPYpaGV+sB+0StjU9OeP98
 tRy0QHfn3hsF8zE1Aq/BMXcz9eW6XrmshNU6mzVrbRp5IwhAeUJu2P0HNXcKc1pCQV2C
 WnUNExQdMC8rBcwLKpfweD2zJQ7hiRYL85Z0298BXC5qxaHuANgjHZkaqk2CWglrqSDR
 vunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U09jkuhbNd4GqgIa8gbKdPQlfgb0wMDSk0hVwDV1gRw=;
 b=IMp7TOLfAM2f/TwQb3Cv3ow6DDit8QVnlxrsduwtqvFWvkN7iB+cuRiWoZI9AZTBHd
 CF5hPoPIAbAIrTtC4Bx5F1QxOFwPtHlS3pvZ0e9eZbVc87IId1Oj/QiRYb/6zFQkgn3k
 8SXacX9q5q7kbAv5gnbk4CzBuDFXgD7cfMfay4oNuySB0KkmJx0q3MUKJ6ZJDH4CQcW9
 wgcqBIEMojSj/km1dPcn/HaqP8+QP6BMgCJP5PiugYzICbfttEl/Qy929KTnLk63veRP
 gXH5GjDI7lhEgJy+8mk205YIBwPzs9M06zKngKh1pGV9NoTFbuDvXAeSfCr0QTH9l1oo
 QVbA==
X-Gm-Message-State: AOAM53008ZSWmK+d91PPfTPVnalR/opQi25FWyw58+hE6UBMHrHC5gpb
 nuMCFjzRmmFM8TNXh1tFkJsBqw==
X-Google-Smtp-Source: ABdhPJx50nBlSlPltZQfbuboqkROjZuWadRs8Z0ewQ8YyTlzSb94+cWlQubdOFAHHuYz9UMUXOaQzw==
X-Received: by 2002:a1c:23d6:: with SMTP id j205mr4416562wmj.120.1617821048827; 
 Wed, 07 Apr 2021 11:44:08 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u10sm8410862wrt.75.2021.04.07.11.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 11:44:08 -0700 (PDT)
Date: Wed, 7 Apr 2021 20:43:50 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YG39ZtnTuyn5uBOa@myrica>
References: <20210322120300.GU2356281@nvidia.com>
 <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
 <fa57bde5-472f-6e66-3521-bfac7d6e4f8d@redhat.com>
 <20210406124251.GO7405@nvidia.com>
 <MWHPR11MB1886A7E4C6F3E3A81240517B8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR11MB1886A7E4C6F3E3A81240517B8C759@MWHPR11MB1886.namprd11.prod.outlook.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li Zefan <lizefan@huawei.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Wu, Hao" <hao.wu@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Apr 07, 2021 at 08:17:50AM +0000, Tian, Kevin wrote:
> btw this discussion was raised when discussing the I/O page fault handling
> process. Currently the IOMMU layer implements a per-device fault reporting
> mechanism, which requires VFIO to register a handler to receive all faults 
> on its device and then forwards to ioasid if it's due to 1st-level. Possibly it 
> makes more sense to convert it into a per-pgtable reporting scheme, and 
> then the owner of each pgtable should register its own handler.

Maybe, but you do need device information in there, since that's how the
fault is reported to the guest and how the response is routed back to the
faulting device (only PASID+PRGI would cause aliasing). And we need to
report non-recoverable faults, as well as recoverable ones without PASID,
once we hand control of level-1 page tables to guests.

> It means
> for 1) VFIO will register a 2nd-level pgtable handler while /dev/ioasid
> will register a 1st-level pgtable handler, while for 3) /dev/ioasid will register 
> handlers for both 1st-level and 2nd-level pgtable. Jean? also want to know 
> your thoughts...  

Moving all IOMMU controls to /dev/ioasid rather that splitting them is
probably better. Hopefully the implementation can reuse most of
vfio_iommu_type1.

I'm trying to sketch what may work for Arm, if we have to reuse
/dev/ioasid to avoid duplication of fault and inval queues:

* Get a container handle out of /dev/ioasid (or /dev/iommu, really.)
  No operation available since we don't know what the device and IOMMU
  capabilities are.

* Attach the handle to a VF. With VFIO that would be
  VFIO_GROUP_SET_CONTAINER. That causes the kernel to associate an IOMMU
  with the handle, and decide which operations are available.

* With a map/unmap vIOMMU (or shadow mappings), a single translation level
  is supported. With a nesting vIOMMU, we're populating the level-2
  translation (some day maybe by binding the KVM page tables, but
  currently with map/unmap ioctl).

  Single-level translation needs single VF per container. Two level would
  allow sharing stage-2 between multiple VFs, though it's a pain to define
  and implement.

* Without a vIOMMU or if the vIOMMU starts in bypass, populate the
  container page tables.

Start the guest.

* With a map/unmap vIOMMU, guest creates mappings, userspace populates the
  page tables with map/unmap ioctl.

  It would be possible to add a PASID mode there: guest requests an
  address space with a specific PASID, userspace derives an IOASID handle
  from the container handle and populate that address space with map/unmap
  ioctl. That would enable PASID on sub-VF assignment, which requires the
  host to control which PASID is programmed into the VF (with
  DEVICE_ALLOW_IOASID, I guess). And either the host allocates the PASID
  in this case (which isn't supported by a vSMMU) or we have to do a
  vPASID -> pPASID. I don't know if it's worth the effort.

Or
* With a nesting vIOMMU, the guest attaches a PASID table to a VF,
  userspace issues a SET_PASID_TABLE ioctl on the container handle. If
  we support multiple VFs per container, we first need to derive a child
  container from the main one and the device, then attach the PASID table.

  Guest programs the PASID table, sends invalidations when removing
  mappings which are relayed to the host on the child container. Page
  faults and response queue would be per container, so if multiple VF per
  container, we could have one queue for the parent (level-2 faults) and
  one for each child (level-1 faults).

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
