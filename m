Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A1FC3A59B
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 07:27:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C493823774
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 07:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C493823774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9857889C;
	Mon,  2 Sep 2019 07:27:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F24A7F6
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 07:26:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E898D709
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 07:26:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1340B227A8A; Mon,  2 Sep 2019 09:26:52 +0200 (CEST)
Date: Mon, 2 Sep 2019 09:26:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v8 3/7] swiotlb: Zero out bounce buffer for untrusted
	device
Message-ID: <20190902072651.GA28587@lst.de>
References: <20190830071718.16613-1-baolu.lu@linux.intel.com>
	<20190830071718.16613-4-baolu.lu@linux.intel.com>
	<20190830073130.GA10471@lst.de>
	<a5edd268-5ba7-a8b6-d883-f4761e52fdff@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a5edd268-5ba7-a8b6-d883-f4761e52fdff@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Sep 02, 2019 at 09:58:27AM +0800, Lu Baolu wrote:
> The untrusted flag is introduced in another series. I agree that we
> could consider to move it to struct device, but I think making it
> in a separated patch looks better.

A separate patch is of course a good idea.  But it needs to happen
before we can use the flag in the swiotlb code.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
