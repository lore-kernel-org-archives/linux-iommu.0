Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CAEC43461
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 11:25:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F713208E4
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 11:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2vInCiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F713208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 43CAD86657;
	Tue, 15 Sep 2020 11:25:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2mIeHIToRjz; Tue, 15 Sep 2020 11:25:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B7068866B1;
	Tue, 15 Sep 2020 11:25:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2E66C0859;
	Tue, 15 Sep 2020 11:25:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0246C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 11:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DEA2487173
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 11:25:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TAbzBWl+nhqH for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:25:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 31F4F8715F
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600169119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=60FvI2fqcP6GhvmqdoyF8WY6GpsYnPO581gMKI3U6q4=;
 b=b2vInCiXczFGhDmMdCx3fpH2746/oy1+MAhuMhoF4UuSrzoZYVPTOIA+Emcqw0HBAkJLA5
 HdHq2MM9lAhYvaF3hrqTqmj1yhS0Ls81YjlVCYtJahBdIQlVeA9897LeogWtd9N1G/QS8Y
 ejeabwcqDw5r/7HE8SbdnR7UIlkQkDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-ni2I88g9NyiUDlg-1Gwv8w-1; Tue, 15 Sep 2020 07:25:15 -0400
X-MC-Unique: ni2I88g9NyiUDlg-1Gwv8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D92E664080;
 Tue, 15 Sep 2020 11:25:13 +0000 (UTC)
Received: from starship (unknown [10.35.207.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 294DB5DDDE;
 Tue, 15 Sep 2020 11:25:10 +0000 (UTC)
Message-ID: <04a8ab5cb1f6662f72bcad856da3415d6d9b2593.camel@redhat.com>
Subject: Re: [PATCH] iommu/amd: fix interrupt remapping for avic
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2020 14:25:01 +0300
In-Reply-To: <60856c61-062b-8d92-e565-38bd00855228@amd.com>
References: <20200913124211.6419-1-mlevitsk@redhat.com>
 <60856c61-062b-8d92-e565-38bd00855228@amd.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Joao Martins <joao.m.martins@oracle.com>
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

On Mon, 2020-09-14 at 21:48 +0700, Suravee Suthikulpanit wrote:
> Maxim,
> 
> On 9/13/2020 7:42 PM, Maxim Levitsky wrote:
> > Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> > accidentally removed an assumption that modify_irte_ga always set the valid bit
> > and amd_iommu_activate_guest_mode relied on that.
> > 
> > Side effect of this is that on my machine, VFIO based VMs with AVIC enabled
> > would eventually crash and show IOMMU errors like that:
> > 
> > AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xfffffffdf8000000 flags=0x0008]
> > 
> > Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >   drivers/iommu/amd/iommu.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 07ae8b93887e5..aff4cc1869356 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -3853,6 +3853,7 @@ int amd_iommu_activate_guest_mode(void *data)
> >   	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
> >   	entry->hi.fields.vector            = ir_data->ga_vector;
> >   	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
> > +	entry->lo.fields_remap.valid = 1;
> >   
> >   	return modify_irte_ga(ir_data->irq_2_irte.devid,
> >   			      ir_data->irq_2_irte.index, entry, ir_data);
> > 
> 
> Could you please try with the following patch instead?
> 
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3840,14 +3840,18 @@ int amd_iommu_activate_guest_mode(void *data)
>   {
>          struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>          struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
> +       u64 valid;
> 
>          if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>              !entry || entry->lo.fields_vapic.guest_mode)
>                  return 0;
> 
> +       valid = entry->lo.fields_vapic.valid;
> +
>          entry->lo.val = 0;
>          entry->hi.val = 0;
> 
> +       entry->lo.fields_vapic.valid       = valid;
>          entry->lo.fields_vapic.guest_mode  = 1;
>          entry->lo.fields_vapic.ga_log_intr = 1;
>          entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
> @@ -3864,12 +3868,14 @@ int amd_iommu_deactivate_guest_mode(void *data)
>          struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>          struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
>          struct irq_cfg *cfg = ir_data->cfg;
> -       u64 valid = entry->lo.fields_remap.valid;
> +       u64 valid;
> 
>          if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>              !entry || !entry->lo.fields_vapic.guest_mode)
>                  return 0;
> 
> +       valid = entry->lo.fields_remap.valid;
> +
>          entry->lo.val = 0;
>          entry->hi.val = 0;
I see. I based my approach on the fact that valid bit was
set always to true anyway before, plus that amd_iommu_activate_guest_mode
should be really only called when someone activates a valid interrupt remapping
entry, but IMHO the approach of preserving the valid bit is safer anyway.

It works on my system (I applied the patch manually, since either your or my email client,
seems to mangle the patch)

Thanks,
Best regards,
	Maxim Levitsky


> --

> 
> Thanks,
> Suravee
> 


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
