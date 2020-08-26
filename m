Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347FBC433DF
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 19:47:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BE0207BC
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 19:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EfWyyyYv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lwTtm5+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BE0207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AA8ED8835D;
	Wed, 26 Aug 2020 19:47:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aX3NP97-Cwoj; Wed, 26 Aug 2020 19:47:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 613D88833E;
	Wed, 26 Aug 2020 19:47:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47CE8C07FF;
	Wed, 26 Aug 2020 19:47:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95490C0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 19:47:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7EF1886BAD
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 19:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id poZMMvadAT4h for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 19:47:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CE73286AFE
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 19:47:41 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1598471258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lyh+OM9Dem9Z/kcK7+gNQJTzyczEFOEY6bG0/Arpun0=;
 b=EfWyyyYv7YWdGg6ZlsB2Gvul0V5au5smJUJLpNMYZSeBiiHKLri6m/Tv5rd3ih560hoGVx
 nzH0lvvST7eWiS1oI2n1KsOHqXKtzHTxLZKpI9SJMhuG+jI5LovFGtPMOPIS2OeEiw7isO
 tmHV0B3teBdD8CSsdyyCabr4Y3t9FTxtENq7B0e0cMS6jhcUUVWnX0K+s+ywdP/VhxrhzZ
 AvJFcEhdDRbeNtKQ1LbQq2JWDBLeMZ2p9QqkeojW3Ekaz6euFWW9jBElfBZUz5/VBdDbaW
 wxAj9R70KvXLkL4n184+rXcNFpLiSbh7hiA6EXnDFal4H8EYpyU37gQ+3u6LTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1598471258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lyh+OM9Dem9Z/kcK7+gNQJTzyczEFOEY6bG0/Arpun0=;
 b=lwTtm5+nHxlSQCA2aszVTEr9Qr/quwfcz0JOyWbmJI+tlH+mPCSRq5hNRIajB+9Hp6kRhm
 8ERxa7qPC4M270AA==
To: Marc Zyngier <maz@kernel.org>
Subject: Re: [patch V2 29/46] irqdomain/msi: Allow to override
 msi_domain_alloc/free_irqs()
In-Reply-To: <87blix2pna.wl-maz@kernel.org>
References: <20200826111628.794979401@linutronix.de>
 <20200826112333.526797548@linutronix.de> <87blix2pna.wl-maz@kernel.org>
Date: Wed, 26 Aug 2020 21:47:38 +0200
Message-ID: <87zh6htcit.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 x86@kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
 Megha Dey <megha.dey@intel.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, Aug 26 2020 at 20:06, Marc Zyngier wrote:
> On Wed, 26 Aug 2020 12:16:57 +0100,
> Thomas Gleixner <tglx@linutronix.de> wrote:
>>  /**
>> - * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
>> - * @domain:	The domain to managing the interrupts
>> + * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
>> + * @domain:	The domain to allocate from
>>   * @dev:	Pointer to device struct of the device for which the interrupts
>> - *		are free
>> + *		are allocated
>> + * @nvec:	The number of interrupts to allocate
>> + *
>> + * Returns 0 on success or an error code.
>>   */
>> -void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
>> +int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>> +			  int nvec)
>> +{
>> +	struct msi_domain_info *info = domain->host_data;
>> +	struct msi_domain_ops *ops = info->ops;
>
> Rework leftovers, I imagine.

Hmm, no. How would it call ops->domain_alloc_irqs() without getting the
ops. I know, that the diff is horrible, but don't blame me for it. diff
sucks at times.

>> +
>> +	return ops->domain_alloc_irqs(domain, dev, nvec);
>> +}
>> +
>> +void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
>>  {
>>  	struct msi_desc *desc;
>>  
>> @@ -513,6 +525,20 @@ void msi_domain_free_irqs(struct irq_dom
>>  }
>>  
>>  /**
>> + * __msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
>
> Spurious __.

Yup.

Thanks,

        tglx
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
