Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A200DC433E2
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:16:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A72E21556
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 10:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyMbFj/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A72E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6276875BB;
	Thu, 10 Sep 2020 10:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id brbPiD9j7f0a; Thu, 10 Sep 2020 10:16:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C91EF875B7;
	Thu, 10 Sep 2020 10:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF51BC0859;
	Thu, 10 Sep 2020 10:16:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25410C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 027B22E189
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:16:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tI7usHdSuDpn for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 10:16:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 9F49220516
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 10:16:38 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id s13so5065193wmh.4
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 03:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DqY3ytm1lW24L4dBr5ZhfVe1Kl4JG7b6aElJixa0DtQ=;
 b=TyMbFj/CCKS/yEhzmJyx0SXASPCumWs129eaMWwliNPHoe9nGlJZk2Tsw17ABtL/mL
 mWke72l5dRMmrFg9ieYmDr1jVfXiMwSmIMEMsNuXAYrMDmbRSlu2SEhpSFeukLVe3cg9
 +5O+wBu+Jx7JfEyF9JNwdrWebHIVozT6N0VTqxSNEjrIsLOZ3R3dejl3APk21PLF2Oj8
 +Kb8ACZuKGttnfzoDexc2yloyF3/YUcCQzcDsr90PZvO0KOXZEocClY8eSC4NnFPV4xO
 lvhsU6vpfnm+pvKWrckJN/8r5bLtL/kaV4lfgkeSIGRnLzVQeQ+BBL7u23nOrwhO07G+
 JHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DqY3ytm1lW24L4dBr5ZhfVe1Kl4JG7b6aElJixa0DtQ=;
 b=nUgubN1CAXKDUn43VDOTvS8NTgkns+ZTPQiphzCSx1RYOIutRHmtErM4kyKMaYDA/W
 DNHQTudu9QqWfV9uB6UrDiPrBRECov22xwr9LmeE33QJ9tYjS7UkTEigpJUaqJ89VY/f
 gXpjiZy/5KR4ddBFhMLUfTDPDSNi+5sSI1gIEphy6YQN3WmbM0Owdh8kQxvL+mY+qLRG
 Kf9qZgl7OdA2jWycKHdo+16RUMXpstxFwW6yCIv6qVLLbaWv/9r+OUmpdjPwWj0b6Cn7
 aB29X6VRuOtGREdq6Sid1HLIG2N/4X+vEEKHkyDcpDONVCfI2XktSpMdExjuzji0Wa2t
 Qn3g==
X-Gm-Message-State: AOAM531u/o9QLZBXWtfKKsy/5hna7JminlIHoIWb/FWJtfczDTIn0wkL
 5WRhXcC6yNK/Hb2BAZQGzsw=
X-Google-Smtp-Source: ABdhPJxz+CTfYBRsr9wPZ8ehDJQEmTq++yYJr4Xo0s0U0R6hQKoUpOmBLcC8LM7TIOPThVoU3WYKbg==
X-Received: by 2002:a1c:234b:: with SMTP id j72mr7837172wmj.153.1599732997083; 
 Thu, 10 Sep 2020 03:16:37 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
 by smtp.gmail.com with ESMTPSA id a127sm2936155wmh.34.2020.09.10.03.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 03:16:36 -0700 (PDT)
Subject: Re: [trivial PATCH] treewide: Convert switch/case fallthrough; to
 break;
To: Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
 Jiri Kosina <trivial@kernel.org>
References: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <81d852d4-115f-c6c6-ef80-17c47ec4849a@gmail.com>
Date: Thu, 10 Sep 2020 12:16:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e6387578c75736d61b2fe70d9783d91329a97eb4.camel@perches.com>
Content-Language: en-US
Cc: linux-fbdev@vger.kernel.org, oss-drivers@netronome.com,
 nouveau@lists.freedesktop.org, alsa-devel <alsa-devel@alsa-project.org>,
 dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
 linux-ide@vger.kernel.org, dm-devel@redhat.com, linux-mtd@lists.infradead.org,
 linux-i2c@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-rtc@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, dccp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 kvmarm@lists.cs.columbia.edu, coreteam@netfilter.org,
 intel-wired-lan@lists.osuosl.org, linux-serial@vger.kernel.org,
 linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
 Kees Cook <kees.cook@canonical.com>, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org,
 storagedev@microchip.com, ceph-devel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Nick Desaulniers <ndesaulniers@google.com>, linux-nfs@vger.kernel.org,
 linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-sctp@vger.kernel.org, iommu@lists.linux-foundation.org,
 netfilter-devel@vger.kernel.org, linux-crypto@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 09/09/2020 22:06, Joe Perches wrote:
> diff --git a/drivers/net/wireless/mediatek/mt7601u/dma.c b/drivers/net/wireless/mediatek/mt7601u/dma.c
> index 09f931d4598c..778be26d329f 100644
> --- a/drivers/net/wireless/mediatek/mt7601u/dma.c
> +++ b/drivers/net/wireless/mediatek/mt7601u/dma.c
> @@ -193,11 +193,11 @@ static void mt7601u_complete_rx(struct urb *urb)
>   	case -ESHUTDOWN:
>   	case -ENOENT:
>   		return;
> +	case 0:
> +		break;
>   	default:
>   		dev_err_ratelimited(dev->dev, "rx urb failed: %d\n",
>   				    urb->status);
> -		fallthrough;
> -	case 0:
>   		break;
>   	}
>   
> @@ -238,11 +238,11 @@ static void mt7601u_complete_tx(struct urb *urb)
>   	case -ESHUTDOWN:
>   	case -ENOENT:
>   		return;
> +	case 0:
> +		break;
>   	default:
>   		dev_err_ratelimited(dev->dev, "tx urb failed: %d\n",
>   				    urb->status);
> -		fallthrough;
> -	case 0:
>   		break;
>   	}

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
