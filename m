Return-Path: <SRS0=Ta7z=LP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1838C4743C
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 17:59:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51326115B
	for <iommu@archiver.kernel.org>; Mon, 21 Jun 2021 17:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51326115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 73955402B6;
	Mon, 21 Jun 2021 17:59:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zt1Qm1rnsf1d; Mon, 21 Jun 2021 17:59:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5CD6540289;
	Mon, 21 Jun 2021 17:59:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13C55C0010;
	Mon, 21 Jun 2021 17:59:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E7DEC000C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 17:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F7A0607DE
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 17:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gm7aUaIiuez for <iommu@lists.linux-foundation.org>;
 Mon, 21 Jun 2021 17:59:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD1FC60609
 for <iommu@lists.linux-foundation.org>; Mon, 21 Jun 2021 17:59:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94438611CE;
 Mon, 21 Jun 2021 17:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624298362;
 bh=y8attfyCFvmhE/rEq1lKuxtMSlY+L9uu0zEo4FMjkv8=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=nVdx/hwygYr/MG4oSfAecQoTkcAWFsVr6dFhXJUhFXwqSbH08hcJcQHHaJ6yNTgwJ
 WFFrnk+RLaMbXPz1Xtr0MorwwBCBRCnNVEqXP2tUXHhGV2Usf3U4gjEu3zxeInr5od
 B9ktxTxXUHFXTSVy1nFGEpPSBK9O5Aws7oD7ucKaVc2hx8hm7IAXVZOQ8U1l9ZRj62
 sEXsTrg9MCBDzVl47wBX5+3xzZhCsWmVRvgAWZv47Xmzv8udI19xFqd0CjGvBvgqzh
 BtSw3vV40r9z2Jdokw3+RVbueWCN8P3KLA5YE9ZkG0ZSqiTJvVk9SGjw4FEHT8nF7N
 esGUOKjtCMepQ==
Date: Mon, 21 Jun 2021 10:59:20 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 01/12] swiotlb: Refactor swiotlb init functions
In-Reply-To: <20210618143212.GA19284@lst.de>
Message-ID: <alpine.DEB.2.21.2106211052270.24906@sstabellini-ThinkPad-T480s>
References: <20210617062635.1660944-1-tientzu@chromium.org>
 <20210617062635.1660944-2-tientzu@chromium.org>
 <alpine.DEB.2.21.2106171434480.24906@sstabellini-ThinkPad-T480s>
 <CALiNf29SJ0jXirWVDhJw4BUNvkjUeGPyGNJK9m8c30OPX41=5Q@mail.gmail.com>
 <741a34cc-547c-984d-8af4-2f309880acfa@amd.com> <20210618143212.GA19284@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: thomas.hellstrom@linux.intel.com, heikki.krogerus@linux.intel.com,
 linux-devicetree <devicetree@vger.kernel.org>, peterz@infradead.org,
 benh@kernel.crashing.org, joonas.lahtinen@linux.intel.com,
 dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk,
 grant.likely@arm.com, paulus@samba.org, Frank Rowand <frowand.list@gmail.com>,
 mingo@kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
 Saravana Kannan <saravanak@google.com>, mpe@ellerman.id.au,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, Tom Lendacky <thomas.lendacky@amd.com>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
 Claire Chang <tientzu@chromium.org>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
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

On Fri, 18 Jun 2021, Christoph Hellwig wrote:
> On Fri, Jun 18, 2021 at 09:09:17AM -0500, Tom Lendacky wrote:
> > > swiotlb_init_with_tbl uses memblock_alloc to allocate the io_tlb_mem
> > > and memblock_alloc[1] will do memset in memblock_alloc_try_nid[2], so
> > > swiotlb_init_with_tbl is also good.
> > > I'm happy to add the memset in swiotlb_init_io_tlb_mem if you think
> > > it's clearer and safer.
> > 
> > On x86, if the memset is done before set_memory_decrypted() and memory
> > encryption is active, then the memory will look like ciphertext afterwards
> > and not be zeroes. If zeroed memory is required, then a memset must be
> > done after the set_memory_decrypted() calls.
> 
> Which should be fine - we don't care that the memory is cleared to 0,
> just that it doesn't leak other data.  Maybe a comment would be useful,
> though,

Just as a clarification: I was referring to the zeroing of "mem" in
swiotlb_late_init_with_tbl and swiotlb_init_with_tbl. While it looks
like Tom and Christoph are talking about the zeroing of "tlb".

The zeroing of "mem" is required as some fields of struct io_tlb_mem
need to be initialized to zero. While the zeroing of "tlb" is not
required except from the point of view of not leaking sensitive data as
Christoph mentioned.

Either way, Claire's v14 patch 01/12 looks fine to me.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
