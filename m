Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7AAC4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 23:22:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D1C20796
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 23:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gkFHJe+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D1C20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9DE88863E0;
	Wed, 28 Oct 2020 23:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id knF2xURr1HkY; Wed, 28 Oct 2020 23:22:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1DD7E86216;
	Wed, 28 Oct 2020 23:22:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1047BC0859;
	Wed, 28 Oct 2020 23:22:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0279C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 23:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D633E86388
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 23:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OboFOV8KZDdB for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 23:22:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 95B8686216
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 23:22:15 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id z24so797667pgk.3
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 16:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XZwWBaJ1YP4eUG0jbcZ/VfZJQEUP/FvDuE+Dcr6WVrA=;
 b=gkFHJe+kUFXAxf/8vOsy2x4sDIItYYYD9odc8xSFN7m2g8lYwKR38kgfTf8zfvYvs7
 yBKIMBqXPuX18tqVHBX3qCSclcuf06y4SGir3XllY4gvU+rJ7oabXjMnWHBu3qRHCt+g
 XDQ0BDU+YDLpbohWX+lRIQe1zsidFRDvJAehw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XZwWBaJ1YP4eUG0jbcZ/VfZJQEUP/FvDuE+Dcr6WVrA=;
 b=cliQYDm7NEaUiiM5EOqFQvejwxyYA67eUMSRxk8PiCyvXJO6vAx3J5SUfC2J/7GiGr
 gWLfkZIJimxBBs7nYVxa8mMeoO/wuwdrR2f5c+vaxTrXiopVqdlZ2I3OiprDbGosATKl
 lY6UnxEgTU2668IOd1n1cpCuKSK3ApFSRqrrHiPRnUFyREO5qfUakimkOw3xK0pyorb/
 xKTnNDkzyDOJ+X/73PxBTFwGs5t2C7Mhu2F2zs1pqbVtErjXJDnkuwNez1SwMevTqqnj
 J8ikg7lrvKgu+Pp431GP0MyKdn8N/2EqtoBdOsMtzhC06mTRNGUN/Faq5R3Zqalia4J5
 j8tQ==
X-Gm-Message-State: AOAM532ujayqxGQuO+dkNiK6/D8kq0kh64w2p1YByA/kARpgXncHN/Zl
 AA5tVdw3AzqxU365NRP9lIPOzw==
X-Google-Smtp-Source: ABdhPJzIxT8kqv3hOAn/eutFdfJq4DAebLsNkfJ0qK4xV8rTZ+MoJFaBn7qxZgXgYmjQNvnQLalLqg==
X-Received: by 2002:a62:e104:0:b029:152:4f37:99da with SMTP id
 q4-20020a62e1040000b02901524f3799damr1294359pfh.17.1603927335230; 
 Wed, 28 Oct 2020 16:22:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id 16sm457419pjf.36.2020.10.28.16.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:22:14 -0700 (PDT)
Date: Wed, 28 Oct 2020 16:22:13 -0700
From: Kees Cook <keescook@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 15/35] PCI: vmd: Use msi_msg shadow structs
Message-ID: <202010281622.40CB2D87@keescook>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
 <20201024213535.443185-1-dwmw2@infradead.org>
 <20201024213535.443185-16-dwmw2@infradead.org>
 <202010281347.2943F5B7@keescook>
 <87blgmf3zj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87blgmf3zj.fsf@nanos.tec.linutronix.de>
Cc: linux-hyperv@vger.kernel.org, kvm <kvm@vger.kernel.org>, x86@kernel.org,
 Dexuan Cui <decui@microsoft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, maz@misterjones.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

On Wed, Oct 28, 2020 at 10:13:52PM +0100, Thomas Gleixner wrote:
> On Wed, Oct 28 2020 at 13:49, Kees Cook wrote:
> > On Sat, Oct 24, 2020 at 10:35:15PM +0100, David Woodhouse wrote:
> >> +	memset(&msg, 0, sizeof(*msg);
> >
> > This should be:
> >
> > +	memset(msg, 0, sizeof(*msg);
> 
>         memset(msg, 0, sizeof(*msg));
> 
> Then it compiles _and_ is correct :)

\o/ ;)

-- 
Kees Cook
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
