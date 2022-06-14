Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB542C433EF
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 07:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6FE21408ED;
	Tue, 14 Jun 2022 07:22:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h_NBiClZsugp; Tue, 14 Jun 2022 07:22:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B139400BB;
	Tue, 14 Jun 2022 07:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20FC7C0032;
	Tue, 14 Jun 2022 07:22:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D296C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F0EC18276E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6F5OEneMjf4G for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 07:22:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED20A825E8
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655191370; x=1686727370;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CzvGOqm3s1ZUzeSM0+qcKhIjvYujoS+oprriCQFDToU=;
 b=VciUY2lwZxMFqUwB9MhOSdfbR/oa+vfuiza3Goc+Fn37NxLiPs7wHXE+
 a+Ww4a5jtnMwJW7TdMgwTWhjZtu9WC7PMHux3Gbi5WWFekyGYCRW+Vewo
 ux9yGLLdMLkjlRF0HnzmFJSWIEuYiPeiT4lnKvWXNfetbVXe72LfjySpP
 X8qk4n80W+Rk6XvQZMJzzcVy2Jkwgy8GJok0jSImI/scu/sW92ksAQbEU
 P3y66BR/8jh69/BjM3NDUXrvR8drMMrQdFMVRtJTURRl7hr2pBdOLjBm1
 HdIIWR27YQgW7DOnMjChubP8W76h/tS3OwjqG4nPhJitRPxXptM6ye2GS Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277314354"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="277314354"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:22:50 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; d="scan'208";a="910837669"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39])
 ([10.255.29.39])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2022 00:22:47 -0700
Message-ID: <c1b8cd0b-6f25-993e-5b96-ce90d855ef26@linux.intel.com>
Date: Tue, 14 Jun 2022 15:22:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 06/12] iommu/vt-d: Acquiring lock in domain ID
 allocation helpers
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52760A3D7C6BF1AF9C9D34658CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760A3D7C6BF1AF9C9D34658CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/6/14 14:52, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 10:52 AM
>>
>> The iommu->lock is used to protect the per-IOMMU domain ID resource.
>> Moving the lock into the ID alloc/free helpers makes the code more
>> compact. At the same time, the device_domain_lock is irrelevant to
>> the domain ID resource, remove its assertion as well.
>>
>> On the other hand, the iommu->lock is never used in interrupt context,
>> there's no need to use the irqsave variant of the spinlock calls.
> 
> I still prefer to separating reduction of lock ranges from changing irqsave.
> Locking is tricky. From bisect p.o.v. it will be a lot easier if we just change
> one logic in one patch.
> 

Fair enough. I will do this in the next version.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
