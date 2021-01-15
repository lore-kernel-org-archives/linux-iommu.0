Return-Path: <SRS0=aa3U=GS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B55C433DB
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 06:31:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659A5235F9
	for <iommu@archiver.kernel.org>; Fri, 15 Jan 2021 06:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659A5235F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EC19D86A58;
	Fri, 15 Jan 2021 06:31:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H5e8qbkDJ94T; Fri, 15 Jan 2021 06:31:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7D31786A4F;
	Fri, 15 Jan 2021 06:31:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E94AC0893;
	Fri, 15 Jan 2021 06:31:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAF9DC013A
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 06:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AE705873EC
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 06:31:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VHtJ+wtWTp7V for <iommu@lists.linux-foundation.org>;
 Fri, 15 Jan 2021 06:31:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3EC2B873E2
 for <iommu@lists.linux-foundation.org>; Fri, 15 Jan 2021 06:31:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56E5E235DD;
 Fri, 15 Jan 2021 06:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610692272;
 bh=eQf9Y8eJMoRe88X1Cj0Th9MUH/4cRNQWkj9gmjjHO9o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cNU0dv+pTcD03IN4pWiZtj4grJN2qC+dzUJhP5y+xNyC95+1of8DZV8hK7RZKrybd
 Q4as6+WsWoXsX1YM0J4TkaCX1DNohy6kw2//t5HvlTGzwAy7uW7/CCDWSwY5haUFAm
 3c5StF0pNe9U1qtT4DHIsxtAqjjtdQ6LLnXGfK1LDoQvO5EVsdBKYeESE7VlHA4f53
 r0WARA4jeZG8sq13IGU3i9i+5MzzG/LIn7anncWcUlBJLfbZGyRHiN9VLH/gQHDDke
 +iBrr1N+fCv0q2nxdyDvAVko6OJLAXMONMfasJ4qQ21tgF0TxNrFxR8DVvAoJiWIcm
 0I0rQGzalcZXQ==
Date: Fri, 15 Jan 2021 08:31:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH v3 1/2] iommu: Add capability IOMMU_CAP_VIOMMU
Message-ID: <20210115063108.GI944463@unreal>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-2-baolu.lu@linux.intel.com>
 <20210114132627.GA944463@unreal>
 <b0c8b260-8e23-a5bd-d2da-ca1d67cdfa8a@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b0c8b260-8e23-a5bd-d2da-ca1d67cdfa8a@linux.intel.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, linux-pci@vger.kernel.org,
 sanjay.k.kumar@intel.com, mona.hossain@intel.com, samuel.ortiz@intel.com,
 kwankhede@nvidia.com, will@kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, netanelg@mellanox.com,
 maz@kernel.org, vkoul@kernel.org, jgg@mellanox.com, yan.y.zhao@linux.intel.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 alex.williamson@redhat.com, bhelgaas@google.com, tglx@linutronix.de,
 megha.dey@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 dmaengine@vger.kernel.org, pbonzini@redhat.com, dwmw2@infradead.org
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

On Fri, Jan 15, 2021 at 07:49:47AM +0800, Lu Baolu wrote:
> Hi Leon,
>
> On 1/14/21 9:26 PM, Leon Romanovsky wrote:
> > On Thu, Jan 14, 2021 at 09:30:02AM +0800, Lu Baolu wrote:
> > > Some vendor IOMMU drivers are able to declare that it is running in a VM
> > > context. This is very valuable for the features that only want to be
> > > supported on bare metal. Add a capability bit so that it could be used.
> >
> > And how is it used? Who and how will set it?
>
> Use the existing iommu_capable(). I should add more descriptions about
> who and how to use it.

I want to see the code that sets this capability.

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
