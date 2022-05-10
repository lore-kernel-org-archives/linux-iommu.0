Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08B3C433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 10:46:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F00E60AAB;
	Tue, 10 May 2022 10:46:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sF0VMC3eq8Pd; Tue, 10 May 2022 10:46:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C1AF60035;
	Tue, 10 May 2022 10:46:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E4EAC0032;
	Tue, 10 May 2022 10:46:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07306C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 10:46:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA577401B7
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 10:46:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q8v9AycVIB9M for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 10:46:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C68F1400FB
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 10:46:47 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id e5so14316693pgc.5
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 03:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=ywkCd0VQclbYtbuLcC/2MBQIqOITw9zVVBZNkCemTOo=;
 b=h0kkPCMH6mPJCfovcbuIStuogjg+GSSyZfKyGX6j68msx5w4YZi0zrfa/0Dshwr3GN
 7RQ1KxIeG1PXDsecsjvmgUcAmrozA5BpQNdXi0GekocXEFlkce+AZEZUg2hxd74t7Q6b
 Gio+Nbtf97oPkaBTUiVEboPYAb85Lj3wwgK1nuRGqbKHKIb7Q1DrfNyYOXBo7RhiuBXk
 BRJbvO0Ri7yOfaOl8eZugNE1EkGkOuWjEy+ngDm4a4V57QfGr3D6FPMoIVpEbsEY4LDc
 vPdwCEsRw6QssvT0owD6Vo+zMVVeU/EruhI3A9lq3SKarrhL+NRBQqOw8YqKP16UoKKY
 qcUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=ywkCd0VQclbYtbuLcC/2MBQIqOITw9zVVBZNkCemTOo=;
 b=PVN8vq/LT1feJBZj0tpJPqytEAr4UWYq/pEZTDCmphOpFodejecum0MXnGEblz7ipd
 S/EQSXKqT+ZHulf6hfwQfuWQVFfPMi8vcbW2ahOhu8jYo1Nfz5f32uM8f9ZtUaMIzWY5
 GVAPmJrfvgFp1d5iw74sztcuB1su8XzyVSCXbFxruCr3jS9Ck4CM82YDMyijlmu/eMvH
 ugcyzpH/3PmaCY5xtWbFd92aYma6qZNziOiO38VVD+feoPdpHd8QpYOyzEbFG5Sgk/F8
 rY5ENDOIVRGjnUBEWvtJrBoGxl77j8Mjs7vSZiW8DRj9UTGpO37/np4B401W7W3cbweE
 lI2A==
X-Gm-Message-State: AOAM5322hcIHqHPFfKAvPq1PYjiMZvbED5YJBzkpw42a2bzxfhdvTraF
 bYxEPUZ8afs544EvtnYFjaU=
X-Google-Smtp-Source: ABdhPJzMrukhfzR4yG2wWMevWm9IkJ0FdxD4csfom41LNkkZtiJ1+e5zsn4K6SEBEKiso2xXU+F2/Q==
X-Received: by 2002:a63:cd41:0:b0:3c5:1242:3a0d with SMTP id
 a1-20020a63cd41000000b003c512423a0dmr16424233pgj.266.1652179607275; 
 Tue, 10 May 2022 03:46:47 -0700 (PDT)
Received: from localhost (193-116-127-232.tpgi.com.au. [193.116.127.232])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a170902bb9800b0015e8d4eb1ecsm1791916pls.54.2022.05.10.03.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 03:46:46 -0700 (PDT)
Date: Tue, 10 May 2022 20:46:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 24/29] watchdog/hardlockup: Use parse_option_str() to
 handle "nmi_watchdog"
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, x86@kernel.org
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
 <20220506000008.30892-25-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20220506000008.30892-25-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-Id: <1652179333.fnu2fjiffn.astroid@bobo.none>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 Ricardo Neri <ricardo.neri@intel.com>, iommu@lists.linux-foundation.org,
 Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

Excerpts from Ricardo Neri's message of May 6, 2022 10:00 am:
> Prepare hardlockup_panic_setup() to handle a comma-separated list of
> options. Thus, it can continue parsing its own command-line options while
> ignoring parameters that are relevant only to specific implementations of
> the hardlockup detector. Such implementations may use an early_param to
> parse their own options.

It can't really handle comma separated list though, until the next
patch. nmi_watchdog=panic,0 does not make sense, so you lost error
handling of that.

And is it kosher to double handle options like this? I'm sure it
happens but it's ugly.

Would you consider just add a new option for x86 and avoid changing
this? Less code and patches.

Thanks,
Nick

> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: x86@kernel.org
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Changes since v5:
>  * Corrected typo in commit message. (Tony)
> 
> Changes since v4:
>  * None
> 
> Changes since v3:
>  * None
> 
> Changes since v2:
>  * Introduced this patch.
> 
> Changes since v1:
>  * None
> ---
>  kernel/watchdog.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 9166220457bc..6443841a755f 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -73,13 +73,13 @@ void __init hardlockup_detector_disable(void)
>  
>  static int __init hardlockup_panic_setup(char *str)
>  {
> -	if (!strncmp(str, "panic", 5))
> +	if (parse_option_str(str, "panic"))
>  		hardlockup_panic = 1;
> -	else if (!strncmp(str, "nopanic", 7))
> +	else if (parse_option_str(str, "nopanic"))
>  		hardlockup_panic = 0;
> -	else if (!strncmp(str, "0", 1))
> +	else if (parse_option_str(str, "0"))
>  		nmi_watchdog_user_enabled = 0;
> -	else if (!strncmp(str, "1", 1))
> +	else if (parse_option_str(str, "1"))
>  		nmi_watchdog_user_enabled = 1;
>  	return 1;
>  }
> -- 
> 2.17.1
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
