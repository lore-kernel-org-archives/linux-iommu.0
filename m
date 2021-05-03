Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA213C433ED
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 16:08:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1912C611BF
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 16:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1912C611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8B395404B4;
	Mon,  3 May 2021 16:08:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id em5_KhqW2wZR; Mon,  3 May 2021 16:08:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4561D404AC;
	Mon,  3 May 2021 16:08:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BF46C000D;
	Mon,  3 May 2021 16:08:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EC0BC0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 16:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 773B560B41
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 16:08:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jnLUMRY13cLC for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 16:08:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87842608B3
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=5jxJ8b/HSUR/7BT5D5WyPEoFYv66JE4BKEKp4HTWf+Y=; b=XWOWwDZ6ZwrouJikaVp8dHiCsr
 I115w+HLBGME9bYlcrjafcglo1GZw06C+Elx221Hmed7QE1HotLNe7+fjXntv4waAOS13LuqEUEIn
 IW2dFINknX+ObrcY9YFIltZb/ozZzUEhKZ702sW1RXa0CfCJuy3VwVNPCow1cpShl+xJ8oX8jXLua
 CqCj1z1wi2T5bZLWF7vRp+RhStCsdQ/r35mSNu80y/H+7gL/KgizhTJPZjwewDohxqwmmbcgGrZd9
 r5urtV1BmH8V5hE2g/eDXD4Qmot0I0KTcAyTeTvQ6Z//Z9oet0bd7OsXbNybLVQ8NF0d8AtcoRbgL
 tLRcrxtw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1ldb7b-0003hs-5l; Mon, 03 May 2021 10:08:36 -0600
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-3-logang@deltatee.com>
 <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
Date: Mon, 3 May 2021 10:08:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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



On 2021-05-01 11:35 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> In order to use upstream_bridge_distance_warn() from a dma_map function,
>> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
>> might sleep.
>>
>> In order to avoid this, try to get the host bridge's device from
>> bus->self, and if that is not set, just get the first element in the
>> device list. It should be impossible for the host bridge's device to
>> go away while references are held on child devices, so the first element
>> should not be able to change and, thus, this should be safe.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/pci/p2pdma.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index bd89437faf06..473a08940fbc 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -311,16 +311,26 @@ static const struct pci_p2pdma_whitelist_entry {
>>   static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>>   				    bool same_host_bridge)
>>   {
>> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>>   	const struct pci_p2pdma_whitelist_entry *entry;
>> +	struct pci_dev *root = host->bus->self;
>>   	unsigned short vendor, device;
>>   
>> +	/*
>> +	 * This makes the assumption that the first device on the bus is the
>> +	 * bridge itself and it has the devfn of 00.0. This assumption should
>> +	 * hold for the devices in the white list above, and if there are cases
>> +	 * where this isn't true they will have to be dealt with when such a
>> +	 * case is added to the whitelist.
> 
> Actually, it makes the assumption that the first device *in the list*
> (the host->bus-devices list) is 00.0.  The previous code made the
> assumption that you wrote.

The comment notes two assumptions (although the grammar is poor, which I
will fix). Yes, the previous code made the second assumption, the new
code makes both assumptions.

> By the way, pre-existing code comment: pci_p2pdma_whitelist[] seems
> really short. From a naive point of view, I'd expect that there must be
> a lot more CPUs/chipsets that can do pci p2p, what do you think? I
> wonder if we have to be so super strict, anyway. It just seems extremely
> limited, and I suspect there will be some additions to the list as soon
> as we start to use this.

Yes, well unfortunately we have no other way to determine what host
bridges can communicate with P2P. We settled on a whitelist when the
series was first patch. Nobody likes that situation, but nobody has
found anything better. We've been hoping standards bodies would give us
a flag but I haven't heard anything about that. At least AMD has been
able to guarantee us that all CPUs newer than Zen will support so that
covers a large swath. It would be nice if we could say something similar
for Intel.

> OK, yes this avoids taking the pci_bus_sem, but it's kind of cheating.
> Why is it OK to avoid taking any locks in order to retrieve the
> first entry from the list, but in order to retrieve any other entry, you
> have to aquire the pci_bus_sem, and get a reference as well? Something
> is inconsistent there.
> 
> The new version here also no longer takes a reference on the device,
> which is also cheating. But I'm guessing that the unstated assumption
> here is that there is always at least one entry in the list. But if
> that's true, then it's better to show clearly that assumption, instead
> of hiding it in an implicit call that skips both locking and reference
> counting.

Because we hold a reference to a child device of the bus. So the host
bus device can't go away until the child device has been released. An
earlier version of the P2PDMA patchset had a lot more extraneous get
device calls until someone else pointed this out.

> You could add a new function, which is a cut-down version of pci_get_slot(),
> like this, and call this from __host_bridge_whitelist():
> 
> /*
>   * A special purpose variant of pci_get_slot() that doesn't take the pci_bus_sem
>   * lock, and only looks for the 00.0 bus-device-function. Once the PCI bus is
>   * up, it is safe to call this, because there will always be a top-level PCI
>   * root device.
>   *
>   * Other assumptions: the root device is the first device in the list, and the
>   * root device is numbered 00.0.
>   */
> struct pci_dev *pci_get_root_slot(struct pci_bus *bus)
> {
> 	struct pci_dev *root;
> 	unsigned devfn = PCI_DEVFN(0, 0);
> 
> 	root = list_first_entry_or_null(&bus->devices, struct pci_dev,
> 					bus_list);
> 	if (root->devfn == devfn)
> 		goto out;
> 
> 	root = NULL;
>   out:
> 	pci_dev_get(root);
> 	return root;
> }
> EXPORT_SYMBOL(pci_get_root_slot);
> 
> ...I think that's a lot clearer to the reader, about what's going on here.

Per above, I think the reference count is unnecessary. But I could wrap
it in a static function for clarity. (There's no reason to export this
function).

> Note that I'm not really sure if it *is* safe, I would need to ask other
> PCIe subsystem developers with more experience. But I don't think anyone
> is trying to make p2pdma calls so early that PCIe buses are uninitialized.

Yeah, it's impossible to make a p2pdma call before the PCIe bus is
initialized. They have to have access to at least one PCI device before
they can even attempt it.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
