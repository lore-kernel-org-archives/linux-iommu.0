Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6995DC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 18:44:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F8761A2B
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 18:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F8761A2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A327A84894;
	Thu, 25 Mar 2021 18:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ygwzbT9rKfws; Thu, 25 Mar 2021 18:44:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 408078486B;
	Thu, 25 Mar 2021 18:44:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 166A1C000E;
	Thu, 25 Mar 2021 18:44:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E135FC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C18E340EFB
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="gKFxuNfs";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="qmchaHgb"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bX9VTX-dGWU6 for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 18:44:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49D3440ED7
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:44:52 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1616697888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sc4ikcvtPux6cS4O7kxP+ZUa35wiLI0ZiU6P4R8vLds=;
 b=gKFxuNfsW+Vl9i0a62FLBGLtEjS1oiWtTzcoKGlxwwcIUkOZ19AIp7e/7xDAtFsOjoO+q0
 CD5ikVGKd4QBstoT/QVAaj3rc9/mYbGV0TC1z9gxYHlfA0QL/E0FgqWfMcgigg5c24lipg
 +N9qaY1tUcDHsKpjlKfflwWw1V30P0IBTgMWClvx2+IgQfAqC+ePAwGvMC0kemqjDlQd04
 nsB3ZNNmPoy14AnvNNwtFmB59GMjC8PZPETs5j5IeVMc9RRt4DkTSHWYQW6hZTOSniCkWf
 eh9YIIpUbp55YG0oSPoR4gCUkEt+EBaAygJ3ZEx2jY3h6LVsn80P3uLtsoE/Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1616697888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sc4ikcvtPux6cS4O7kxP+ZUa35wiLI0ZiU6P4R8vLds=;
 b=qmchaHgbktj5g1ZW7Fad7vH+aDWR4zgUUjC2juXG48RpTVOp8FNuX94Gq1nnM012a9qPrp
 vukNwVgphsGYiiBA==
To: Marc Zyngier <maz@kernel.org>, Megha Dey <megha.dey@intel.com>
Subject: Re: [Patch V2 07/13] irqdomain/msi: Provide msi_alloc/free_store()
 callbacks
In-Reply-To: <8735wjrwjm.wl-maz@kernel.org>
References: <1614370277-23235-1-git-send-email-megha.dey@intel.com>
 <1614370277-23235-8-git-send-email-megha.dey@intel.com>
 <8735wjrwjm.wl-maz@kernel.org>
Date: Thu, 25 Mar 2021 19:44:48 +0100
Message-ID: <87lfabvzrz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Cc: alex.williamson@redhat.com, kevin.tian@intel.com, tony.luck@intel.com,
 dave.jiang@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 ravi.v.shankar@intel.com, linux-pci@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jgg@mellanox.com, bhelgaas@google.com, dan.j.williams@intel.com,
 dwmw@amazon.co.uk
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

On Thu, Mar 25 2021 at 17:08, Marc Zyngier wrote:
> Megha Dey <megha.dey@intel.com> wrote:
>> @@ -434,6 +434,12 @@ int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (ops->msi_alloc_store) {
>> +		ret = ops->msi_alloc_store(domain, dev, nvec);
>
> What is supposed to happen if we get aliasing devices (similar to what
> we have with devices behind a PCI bridge)?
>
> The ITS code goes through all kind of hoops to try and detect this
> case when sizing the translation tables (in the .prepare callback),
> and I have the feeling that sizing the message store is analogous.

No. The message store itself is sized upfront by the underlying 'master'
device. Each 'master' device has it's own irqdomain.

This is the allocation for the subdevice and this is not part of PCI and
therefore not subject to PCI aliasing.

  |-----------|
  |  PCI dev  |         <- driver creates irqdomain and manages MSI
  |-----------|            Sizing is either fixed (hardware property)
                           or just managed by that irqdomain/driver
                           with some hardware constraints
       |subdev|         <- subdev gets ^^irqdomain assigned and
                           allocates from it.
       .....
       |subdev|

So this is fundamentally different from ITS because ITS has to size the
translation memory, i.e. where the MSI message is written to by the
device.

IMS just handles the storage of the message in the (sub)device. So if
that needs to be supported on ARM then the issue is not with the
subdevices, the issue is with the 'master' device, but that does not use
that alloc_store() callback as it provides it with the irqdomain it
manages.

Thanks,

        tglx


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
