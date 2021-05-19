Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04581C433B4
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 19:19:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC60611B0
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 19:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC60611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DB4C60754;
	Wed, 19 May 2021 19:19:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dsF88hBHyU0j; Wed, 19 May 2021 19:19:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67C5D606D4;
	Wed, 19 May 2021 19:19:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ECEEC000E;
	Wed, 19 May 2021 19:19:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F571C0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 19:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F395A60754
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 19:19:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6akX8pEAGbMs for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 19:19:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64BF5606D4
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 19:19:48 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id q2so10567211pfh.13
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ghVDOoMvorTJdaMzHQG/RIv5BmHhyL6sw4dTSHsJEnU=;
 b=rcLYOAKu9u/Pk2N2pIINoWg7Qql5CHIaTXPW1rmbbrFNRBJ17e6P88xZ/Yr3+K40Vg
 KFK9I+oMG/IgtitN6mi8iqL0UX94lczwdh7i0nBMb8jue1bBvD+G4ynJruy5PLRKgM8v
 188V9tFxrPE9B0B1aPKzXgftN+LtzT071WIlfZD+1U+hRwMChhgRPMvMzKYVh5Q7yJyY
 X233KhJbv3QXKhh18IR7fU0ZBHQkRzKr/brYbrWfvUGYpz9WfdE1CfhVQ0XA+pTrnR5x
 VWSQyHCExyqYP4xFwbo2E8+nGlIJeknoGezPntMeUW6YyiidoBVXS6cxaKILk/O3+EJK
 3+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ghVDOoMvorTJdaMzHQG/RIv5BmHhyL6sw4dTSHsJEnU=;
 b=bsqAT8JeLsPEYm2Q/0KvdjL2CM7kXUrmEk+xiG2nymeISQmYOYySKuRMtG7O4Zm709
 nVPhM6e2cGxnv9CSdZro+0bFJtEb5z/KbIT6G2TlDlJU+Vti4ncFyFSzQVKt/Nre6DPb
 Ry402IrNuNzue/p7x69MdLaE4lF/OIj5zilKeVQtNLhfRbH2QQlu/GZ7ThlZlH36OTFa
 fssyoQI92FQtvmuZPDrSjFz/uK+40tEMnYBYHf321VUdb4fhd9cOrBk7n169TFaIr9QD
 +vNzzrlCueyvAKRHJaeEAJFE7TlhMsbXiN8Ovo0SaxzL5lSpZiFLnyP9W93Fm43CiKkn
 F29w==
X-Gm-Message-State: AOAM53190uVAzeB4TUZeTjZ/HoS3uP1CfAxvRsc2ZJDIgV1MDF6+wo3e
 MyHtDWVSkR8nn6GyNkXS8e8=
X-Google-Smtp-Source: ABdhPJwjgDsBVD45dTtfq/CuwPFV8Nn9xvyX5u2jGlIQAuONAFWU5ZnSLNw+gRQXo9RnVxq5dGzq7g==
X-Received: by 2002:a63:4e01:: with SMTP id c1mr645397pgb.265.1621451987803;
 Wed, 19 May 2021 12:19:47 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y66sm128104pgb.14.2021.05.19.12.19.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 12:19:47 -0700 (PDT)
Subject: Re: [PATCH v7 06/15] swiotlb: Update is_swiotlb_buffer to add a
 struct device argument
To: Claire Chang <tientzu@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 mpe@ellerman.id.au, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-7-tientzu@chromium.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e825f332-eabe-4a82-1528-8bc9d1e60625@gmail.com>
Date: Wed, 19 May 2021 12:19:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-7-tientzu@chromium.org>
Content-Language: en-US
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, rodrigo.vivi@intel.com,
 bhelgaas@google.com, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Update is_swiotlb_buffer to add a struct device argument. This will be
> useful later to allow for restricted DMA pool.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
