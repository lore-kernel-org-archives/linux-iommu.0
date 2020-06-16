Return-Path: <SRS0=6LHv=75=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7528FC433DF
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 08:33:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3693020656
	for <iommu@archiver.kernel.org>; Tue, 16 Jun 2020 08:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2zYcdJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3693020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E6DBE89418;
	Tue, 16 Jun 2020 08:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NacxdnL7lhQl; Tue, 16 Jun 2020 08:33:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 76A4489410;
	Tue, 16 Jun 2020 08:33:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E9DAC07FF;
	Tue, 16 Jun 2020 08:33:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C17A4C016E
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 08:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BE0BC87721
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 08:33:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5mV1YvhQO4A7 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Jun 2020 08:33:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F41C6875F8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 08:33:51 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id c17so22452381lji.11
 for <iommu@lists.linux-foundation.org>; Tue, 16 Jun 2020 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8IjNpcb5GlLP8oh8x0KUTPeP/cupRlI8efPDAe078Wg=;
 b=n2zYcdJI10LwDXrUDK71pELIpej3d4vK23sWHQIG+DTNiP7rBB2Ydlo3ni2NhqKlw0
 qmgjqRyWrTNKRJqtcN54fNNbVchNxv0UCZ8UD6A5n0N9veGqYXg67ZE1JHCqEN7GwO5N
 bEzMy2pQBU1i7k0Z/9BJp4fSpA1uwPrI9uPISnm1l2c83I4urBxMP6qXHOXcm7LqT474
 DkWGGV7iqbwvNUH1ffz861zJTpj+CcmYfrKxZNalIwc2nhiDZQK3HmY8x01t6j0g8Rzp
 21hq2PicDxmT3+wENPx4ZJnox12QbkNo3+5pkq+RlLl6x1a38Mh53C7YsX6mxJYhTMLu
 rlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8IjNpcb5GlLP8oh8x0KUTPeP/cupRlI8efPDAe078Wg=;
 b=AnWE9inyMu61NDkCcEj0tudSCYctSndcNkNxMfI8ycyPytO7OKe3qSZB54d8UXN8iD
 5t5G0nW3jDQg3ccEP49zwHhtzUibsB/jycxI7/vYGImXK2tHe5/X2113LQoDrOnXiFjV
 dy92KeICEUQlOiZzAQTgrCP0cX22APZ0iF09T4Ul0Q0wjdsiwe6YI6KZS4MdZScaw0hy
 rqDbf+WPwKzAXAvhL6dEsJZosbXUawKVCw6aJvw12GMcWg3LoxzwS6t+oqYyqb9+cFSs
 1TVI7BEf4kAmnxjo7VuUXbZEz/VidNEzOzU6lI4VETLnP0MRdxxKHTI0pbLqwijp2uWZ
 3dag==
X-Gm-Message-State: AOAM533dBWxWxsbJFGwBsSkA9Anq/yefv+vlNvYQk22/4zqt2rQu7+FL
 yTaaqAV/48pUi8wBEjopXTg2+AW6qDxURw==
X-Google-Smtp-Source: ABdhPJwdmGZqCbPQVfP2PbF9SY5ULvsP9RvSngnjuu0AyNddv0ojHPfA/jhOP8zjYvYdGToRfiyJAw==
X-Received: by 2002:a17:906:6b92:: with SMTP id
 l18mr1733654ejr.145.1592296110725; 
 Tue, 16 Jun 2020 01:28:30 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c4sm10680797ejz.104.2020.06.16.01.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 01:28:30 -0700 (PDT)
Date: Tue, 16 Jun 2020 10:28:19 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 08/12] mm: Define pasid in mm
Message-ID: <20200616082819.GA590740@myrica>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-9-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592008893-9388-9-git-send-email-fenghua.yu@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 x86 <x86@kernel.org>, amd-gfx <amd-gfx@lists.freedesktop.org>,
 Ingo Molnar <mingo@redhat.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Yu-cheng Yu <yu-cheng.yu@intel.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>
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

On Fri, Jun 12, 2020 at 05:41:29PM -0700, Fenghua Yu wrote:
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 64ede5f150dc..5778db3aa42d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -538,6 +538,10 @@ struct mm_struct {
>  		atomic_long_t hugetlb_usage;
>  #endif
>  		struct work_struct async_put_work;
> +
> +#ifdef CONFIG_PCI_PASID

Non-PCI devices can also use a PASID (e.g. Arm's SubstreamID). How about
CONFIG_IOMMU_SUPPORT?

Thanks,
Jean

> +		unsigned int pasid;
> +#endif
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
