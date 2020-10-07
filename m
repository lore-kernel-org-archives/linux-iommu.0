Return-Path: <SRS0=58s/=DO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1DBC41604
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 08:14:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5AA32076C
	for <iommu@archiver.kernel.org>; Wed,  7 Oct 2020 08:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1MM7SZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5AA32076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0ED8D871D9;
	Wed,  7 Oct 2020 08:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cRz7By3Vn0fZ; Wed,  7 Oct 2020 08:14:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 53569871CA;
	Wed,  7 Oct 2020 08:14:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36AC3C016F;
	Wed,  7 Oct 2020 08:14:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 814F8C0051
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 08:14:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7B73C204EC
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 08:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mRRASdcyz0Zt for <iommu@lists.linux-foundation.org>;
 Wed,  7 Oct 2020 08:14:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 226C5204EA
 for <iommu@lists.linux-foundation.org>; Wed,  7 Oct 2020 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602058473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FO0ylTwxsFibALiQNRYyuOtFrkYnW5pOZMct+3/gDn0=;
 b=A1MM7SZXj1mLAB6lhfmOkf3Et2UnmCZz8H3jeQSXVVzXNNkdDS6Yn6j3KSSiUFlkdp8nZ0
 z43rfVOWY6gq1udjcL4/NzGKeHl7WAzPqqPPCDojKUgdrAd6IGTTjpvRmCOVC8kUGFeoSE
 oWgspij9gTzn29eTxRFVAhIgyjAtoV0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-Jvr9I2MWN6qTfjWIlfI0Hw-1; Wed, 07 Oct 2020 04:14:32 -0400
X-MC-Unique: Jvr9I2MWN6qTfjWIlfI0Hw-1
Received: by mail-wr1-f71.google.com with SMTP id v5so670365wrr.0
 for <iommu@lists.linux-foundation.org>; Wed, 07 Oct 2020 01:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FO0ylTwxsFibALiQNRYyuOtFrkYnW5pOZMct+3/gDn0=;
 b=RSS0gDg1bCisNWqjbFm3lUecpX+HT7RLiWaeWUDchZVRhLwHxvZ7Fp0sd3SXovbiAw
 Cbu/CLoy4Sex+6SteFfDYyELKBVJxsQwhctu9V4moMgGpjKJk2GLrLbAv4la/DW+xdGi
 AKC31e0kFXGR2vmOu03nJP4pTw7yBTzWkQWohDlpUCXzFAHFlFOTW8Dlev9mouzsWpcS
 ZB56d9cnURNz5VrgwELVGIo3dLXqdLbJoicslqk30dnwRaOOC21n7lcPZaWEfW1boc4h
 BBNg6k1CdnvJ7KyUd84PiRmZIRJFSE5BpjMMhuVcZwngvo53zn2+rpteDYHoFlOJlw9h
 75wA==
X-Gm-Message-State: AOAM533rUGMCk0ZuCM2jr/5UCJcb+V+0Hb47b3ERD1aWAOIN8t4j3P5Z
 gfL58Y8Xt8mqs5rvRqrIHz7lNZaM2PT0SvPRI7T7oNfgvaWPfgxKjJGj/v2vVYfWxQ1B8POuKqC
 phOzznGgLHcL+8MlT+Vm6sJ1KGU9nrQ==
X-Received: by 2002:adf:ec06:: with SMTP id x6mr2071159wrn.404.1602058470973; 
 Wed, 07 Oct 2020 01:14:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFA/NpUmddmBqpHG4PhSr4PEf9UoUBToNUEttKhZEAEft5UqjvPixuATGiNm9eSRs4VMCUZg==
X-Received: by 2002:adf:ec06:: with SMTP id x6mr2071136wrn.404.1602058470739; 
 Wed, 07 Oct 2020 01:14:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d2f4:5943:190c:39ff?
 ([2001:b07:6468:f312:d2f4:5943:190c:39ff])
 by smtp.gmail.com with ESMTPSA id a127sm1678866wmh.13.2020.10.07.01.14.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 01:14:30 -0700 (PDT)
Subject: Re: [PATCH 13/13] x86/kvm: Add KVM_FEATURE_MSI_EXT_DEST_ID
To: David Woodhouse <dwmw2@infradead.org>, x86@kernel.org
References: <77e64f977f559412f62b467fd062d051ea288f14.camel@infradead.org>
 <20201005152856.974112-1-dwmw2@infradead.org>
 <20201005152856.974112-13-dwmw2@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <472a34e3-2981-0c7b-1fb0-da8debbdc728@redhat.com>
Date: Wed, 7 Oct 2020 10:14:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005152856.974112-13-dwmw2@infradead.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: iommu <iommu@lists.linux-foundation.org>, linux-hyperv@vger.kernel.org,
 kvm <kvm@vger.kernel.org>
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

On 05/10/20 17:28, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This allows the host to indicate that IOAPIC and MSI emulation supports
> 15-bit destination IDs, allowing up to 32Ki CPUs without remapping.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  Documentation/virt/kvm/cpuid.rst     | 4 ++++
>  arch/x86/include/uapi/asm/kvm_para.h | 1 +
>  arch/x86/kernel/kvm.c                | 6 ++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/cpuid.rst b/Documentation/virt/kvm/cpuid.rst
> index a7dff9186bed..1726b5925d2b 100644
> --- a/Documentation/virt/kvm/cpuid.rst
> +++ b/Documentation/virt/kvm/cpuid.rst
> @@ -92,6 +92,10 @@ KVM_FEATURE_ASYNC_PF_INT          14          guest checks this feature bit
>                                                async pf acknowledgment msr
>                                                0x4b564d07.
>  
> +KVM_FEATURE_MSI_EXT_DEST_ID       15          guest checks this feature bit
> +                                              before using extended destination
> +                                              ID bits in MSI address bits 11-5.
> +
>  KVM_FEATURE_CLOCSOURCE_STABLE_BIT 24          host will warn if no guest-side
>                                                per-cpu warps are expeced in
>                                                kvmclock
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 812e9b4c1114..950afebfba88 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -32,6 +32,7 @@
>  #define KVM_FEATURE_POLL_CONTROL	12
>  #define KVM_FEATURE_PV_SCHED_YIELD	13
>  #define KVM_FEATURE_ASYNC_PF_INT	14
> +#define KVM_FEATURE_MSI_EXT_DEST_ID	15
>  
>  #define KVM_HINTS_REALTIME      0
>  
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 1b51b727b140..4986b4399aef 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -743,12 +743,18 @@ static void __init kvm_init_platform(void)
>  	x86_platform.apic_post_init = kvm_apic_init;
>  }
>  
> +static bool __init kvm_msi_ext_dest_id(void)
> +{
> +	return kvm_para_has_feature(KVM_FEATURE_MSI_EXT_DEST_ID);
> +}
> +
>  const __initconst struct hypervisor_x86 x86_hyper_kvm = {
>  	.name			= "KVM",
>  	.detect			= kvm_detect,
>  	.type			= X86_HYPER_KVM,
>  	.init.guest_late_init	= kvm_guest_init,
>  	.init.x2apic_available	= kvm_para_available,
> +	.init.msi_ext_dest_id	= kvm_msi_ext_dest_id,
>  	.init.init_platform	= kvm_init_platform,
>  };
>  
> 

Looks like the rest of the series needs some more work, but anyway:

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
