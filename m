Return-Path: <SRS0=cHis=CZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B212C433E2
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 15:12:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B3222454
	for <iommu@archiver.kernel.org>; Wed, 16 Sep 2020 15:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZC6xdPMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B3222454
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9C63822DEC;
	Wed, 16 Sep 2020 15:12:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jfQDT4QG1tz0; Wed, 16 Sep 2020 15:12:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 45B10228A7;
	Wed, 16 Sep 2020 15:12:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 273B6C0864;
	Wed, 16 Sep 2020 15:12:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB799C0051
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 15:12:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B32C48739B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 15:12:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7N31BjVc+nnX for <iommu@lists.linux-foundation.org>;
 Wed, 16 Sep 2020 15:12:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D49158738E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Sep 2020 15:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600269163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0FBHbk68iVZgx7bJXMjUxCpKA5G+DPHMYndfXbzqZBk=;
 b=ZC6xdPMH3Fq4/eSxY+JHVmj1JR17/lVe5tvbhpepSBBfAH2p29STLw55Q0kE5E76xwQOeP
 jcHYzNfca036KjUW4mCNjuxd4NPNtzwW2aAAXxbSI3oJ6XQz0uLu49uMVCqcdycgiKC6ja
 HKm7VYSkMYUQgJmlGDXF4eTR3lYJOr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ssaaT3QjOJKzRu4Ac00xZA-1; Wed, 16 Sep 2020 11:12:41 -0400
X-MC-Unique: ssaaT3QjOJKzRu4Ac00xZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E7064095;
 Wed, 16 Sep 2020 15:12:39 +0000 (UTC)
Received: from starship (unknown [10.35.206.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD9F25FC36;
 Wed, 16 Sep 2020 15:12:37 +0000 (UTC)
Message-ID: <adcd725ec06d2a72de4f7e035edc743697fdbbb2.camel@redhat.com>
Subject: Re: [PATCH v2] iommu/amd: Restore IRTE.RemapEn bit for
 amd_iommu_activate_guest_mode
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Date: Wed, 16 Sep 2020 18:12:36 +0300
In-Reply-To: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
References: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Joao Martins <joao.m.martins@oracle.com>
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

On Wed, 2020-09-16 at 11:17 +0000, Suravee Suthikulpanit wrote:
> Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating
> 128-bit IRTE") removed an assumption that modify_irte_ga always set
> the valid bit, which requires the callers to set the appropriate value
> for the struct irte_ga.valid bit before calling the function.
> 
> Similar to the commit 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn
> bit after programming IRTE"), which is for the function
> amd_iommu_deactivate_guest_mode().
> 
> The same change is also needed for the amd_iommu_activate_guest_mode().
> Otherwise, this could trigger IO_PAGE_FAULT for the VFIO based VMs with
> AVIC enabled.
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Tested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e938677af8bc..db4fb840c59c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3900,14 +3900,18 @@ int amd_iommu_activate_guest_mode(void *data)
>  {
>  	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>  	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
> +	u64 valid;
>  
>  	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>  	    !entry || entry->lo.fields_vapic.guest_mode)
>  		return 0;
>  
> +	valid = entry->lo.fields_vapic.valid;
> +
>  	entry->lo.val = 0;
>  	entry->hi.val = 0;
>  
> +	entry->lo.fields_vapic.valid       = valid;
>  	entry->lo.fields_vapic.guest_mode  = 1;
>  	entry->lo.fields_vapic.ga_log_intr = 1;
>  	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
