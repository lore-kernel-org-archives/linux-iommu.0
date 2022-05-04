Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407B1C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 11:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 028B283ED5;
	Wed,  4 May 2022 11:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3IdZxEZew2cX; Wed,  4 May 2022 11:53:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED1FC83ED2;
	Wed,  4 May 2022 11:53:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D68D6C0039;
	Wed,  4 May 2022 11:53:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CA81C002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B4A740488
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:53:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 180NelcwpdIg for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 11:53:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A4B8540157
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:53:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 160893FA; Wed,  4 May 2022 13:53:42 +0200 (CEST)
Date: Wed, 4 May 2022 13:53:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [bug] NULL pointer deref after 3f6634d997db ("iommu: Use right
 way to retrieve iommu_ops")
Message-ID: <YnJpQiEJWNjyOyji@8bytes.org>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-8-baolu.lu@linux.intel.com>
 <20220504075356.GA2361844@janakin.usersys.redhat.com>
 <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d6c30e0-dcf7-56f8-c44b-2d8bdb1dc04c@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 bgoncalv@redhat.com, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Ben Skeggs <bskeggs@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Will Deacon <will@kernel.org>, Jan Stancek <jstancek@redhat.com>
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

Hi Robin,

On Wed, May 04, 2022 at 12:14:07PM +0100, Robin Murphy wrote:
> Oof, this can probably be hit with vfio-noiommu too, and by the look of
> things, `echo auto > /sys/kernel/iommu_groups/0/type` would likely blow
> up as well. Does the patch below work for you?

Thanks for the quick patch! I am delaying to send iommu-fixes upstream
for now in the hope the fix can make it into the branch asap. Please
send it out as a separate patch as soon as it is successfully tested.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
