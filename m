Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAC9C433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 12:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0BBD605B1;
	Fri,  8 Apr 2022 12:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VKQyWNKth5ZY; Fri,  8 Apr 2022 12:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D6A9D60AC2;
	Fri,  8 Apr 2022 12:22:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE45AC0033;
	Fri,  8 Apr 2022 12:22:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76F49C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 12:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64C1460AC2
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 12:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dG328d8bVbZF for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 12:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFB01605B1
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649420566; x=1680956566;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/RplksVmRXLomtAsgB8+45tl/KicGkQUKXTegbelxEQ=;
 b=JZUHcV7QZfl1FYKTJDMWX/WXHUyDagv613c4VvxRvnmJrYzOba4TTxj1
 IU3N+Erc6hXSmt7N1OU+LCp3+nh8s8Y50ki+NVrgbRj4xMeXZM7cq+T3r
 BA+TBlNP2jRkoxU0V0+kJOk/quQQfedPPI0isMA6BfLD5IUBcTnrf6Xks
 NdN7CWbzq8nuBa+hXeReEU10GPx7Bq7MA8HHd7NNI34t0D8c+2z8gWMFx
 oM/9dvzB8o8UCMEL4sbLvVNoFU4jH1ZQMaJESICImj3kZuLZWaeMeTUZ5
 tAPouTsmYg3Io8yiJSLMibRL79ZJmsNTwxqDgT0YgY4KoqakGvsYup6Kn Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="348019193"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; d="scan'208";a="348019193"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2022 05:22:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; d="scan'208";a="550484807"
Received: from lixia19x-mobl3.ccr.corp.intel.com (HELO [10.254.209.148])
 ([10.254.209.148])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2022 05:22:37 -0700
Message-ID: <1033ebe4-fa92-c9bd-a04b-8b28b21e25ea@linux.intel.com>
Date: Fri, 8 Apr 2022 20:22:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220308054421.847385-1-baolu.lu@linux.intel.com>
 <20220315002125.GU11336@nvidia.com> <Yk/q1BGN8pC5HVZp@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <Yk/q1BGN8pC5HVZp@8bytes.org>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Joerg,

On 2022/4/8 15:57, Joerg Roedel wrote:
> On Mon, Mar 14, 2022 at 09:21:25PM -0300, Jason Gunthorpe wrote:
>> Joerg, are we good for the coming v5.18 merge window now? There are
>> several things backed up behind this series.
> 
> I usually don't apply bigger changes like this after -rc7, so it didn't
> make it. Please re-send after -rc3 is out and I will consider it.

Sure. I will do.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
