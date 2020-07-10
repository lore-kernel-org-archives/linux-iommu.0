Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABC9C433DF
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:27:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E1520786
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 23:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZlDt7fat"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E1520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2DFF787C0A;
	Fri, 10 Jul 2020 23:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ua48Snuf--ww; Fri, 10 Jul 2020 23:27:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A76BA87B34;
	Fri, 10 Jul 2020 23:27:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9677DC0890;
	Fri, 10 Jul 2020 23:27:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48F6FC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 357B989D3C
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ebCxM58eKGBX for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 23:27:47 +0000 (UTC)
X-Greylist: delayed 17:24:54 by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 85FD189D38
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 23:27:47 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id t15so3247595pjq.5
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 16:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:in-reply-to:references
 :subject:from:cc:to:date:message-id:user-agent;
 bh=1KgjCvGYsPEwY3hIMJvN1I+nBQQMZD4O0k3S1JS7Jzc=;
 b=ZlDt7fatfStgfAIZPJqQmlFZpkGnO9iuPVXSVxTanufGMgMlhHMxUo3jBKYtQE0znR
 SR+WcB3ZwxCGOtVUKtjcgO3ePLoorGRfPXAf8M25lOws0li5gXoYvmem/P6VagpqImRt
 nKL/T8GT3xJGbkcTdHWmqEubc/Zzg+gpv+ePc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding
 :in-reply-to:references:subject:from:cc:to:date:message-id
 :user-agent;
 bh=1KgjCvGYsPEwY3hIMJvN1I+nBQQMZD4O0k3S1JS7Jzc=;
 b=lBzrPIhNyCHc5GpI781JdsXJAQL+G21CSgGzuGbEgzc3WROoqviy4WOyRaHXHuo/Mu
 OsCMs1g4h7Ai3q6/NAHKagSlCLUX7yzpmVn12NZtIQwk/Noimedmm9l++MFKuBxPQyA1
 lKpKL7ceoWcU0Zk2MbCpsd5Tjq+7O8VaijI5BhUcbdfbtbNS/P1ANmDMoQJxT4crSjEn
 YQsN/Q2fp/gbk39DPeoHOMMbQ0DR9ek+PRTBAwHkXKZLANdL8Wp0Sp0UymT2kbSRc11r
 wQxXjGV1yQXtAfXNNszcRg4sb5VSMcXrfgF6+bJaFxH3Z2wJ0wdCOCq3HWzhiWIt/f7U
 0x8A==
X-Gm-Message-State: AOAM533sxGFzRILG9N+5onp6nzWnujqu2fhVg11stXmb1/B4EpdFTcFH
 NOEafU7tcIIpkO2l5QF0u62FCw==
X-Google-Smtp-Source: ABdhPJwkvHuJGy/BobEJFjeeamXIZFvC9w8oHpTxafgWv0gdfY9kS4v8UzTMQwlP2PwG+JyMcl0n+w==
X-Received: by 2002:a17:90b:23d5:: with SMTP id
 md21mr8444282pjb.0.1594423667073; 
 Fri, 10 Jul 2020 16:27:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
 by smtp.gmail.com with ESMTPSA id o17sm6475469pjq.6.2020.07.10.16.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 16:27:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALAqxLW14f4Gn6Q3b89X10y7=Zct2NJSgjagUqxez_bObcp42w@mail.gmail.com>
References: <20200625001039.56174-1-john.stultz@linaro.org>
 <20200625001039.56174-4-john.stultz@linaro.org>
 <159315737502.62212.16093934831673347066@swboyd.mtv.corp.google.com>
 <CALAqxLVNGar8g+FvHaVHN_e-MOZZ+=ZPmDt_GKKSC8AS-wLFGg@mail.gmail.com>
 <87wo3setn8.wl-maz@kernel.org>
 <159436097057.1987609.13993891118929459851@swboyd.mtv.corp.google.com>
 <CALAqxLW14f4Gn6Q3b89X10y7=Zct2NJSgjagUqxez_bObcp42w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] irqchip: Allow QCOM_PDC to be loadable as a
 permanent module
From: Stephen Boyd <swboyd@chromium.org>
To: John Stultz <john.stultz@linaro.org>
Date: Fri, 10 Jul 2020 16:27:45 -0700
Message-ID: <159442366514.1987609.434612639050774557@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Cc: Maulik Shah <mkshah@codeaurora.org>, Jason Cooper <jason@lakedaemon.net>,
 Saravana Kannan <saravanak@google.com>, Marc Zyngier <maz@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
 linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, Todd Kjos <tkjos@google.com>
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

Quoting John Stultz (2020-07-10 15:44:18)
> On Thu, Jul 9, 2020 at 11:02 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Does it work? I haven't looked in detail but I worry that the child
> > irqdomain (i.e. pinctrl-msm) would need to delay probing until this
> > parent irqdomain is registered. Or has the hierarchical irqdomain code
> > been updated to handle the parent child relationship and wait for things
> > to probe or be loaded?
> 
> So I can't say I know the underlying hardware particularly well, but
> I've been using this successfully on the Dragonboard 845c with both
> static builds as well as module enabled builds.
> And the same patch has been in the android-mainline and android-5.4
> kernels for a while without objections from QCOM.
> 
> As to the probe ordering question, Saravana can maybe speak in more
> detail if it's involved in this case but the fw_devlink code has
> addressed many of these sorts of ordering issues.
> However, I'm not sure if I'm lucking into the right probe order, as we
> have been able to boot android-mainline w/ both fw_devlink=on and
> fw_devlink=off (though in the =off case, we need
> deferred_probe_timeout=30 to give us a bit more time for modules to
> load after init starts).
> 

Ok I looked at the code (sorry for not checking earlier) and I see this in
msm_gpio_init()

        np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
        if (np) {
                chip->irq.parent_domain = irq_find_matching_host(np,
                                                 DOMAIN_BUS_WAKEUP);
                of_node_put(np);
                if (!chip->irq.parent_domain)
                        return -EPROBE_DEFER;

so it looks like we'll probe defer the pinctrl driver until the pdc module
loads. Meaning it should work to have pinctrl builtin and pdc as a module.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
