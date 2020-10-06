Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B1CC41604
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 07:19:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E4120789
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 07:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E4120789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AC7048445A;
	Tue,  6 Oct 2020 07:19:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o4K0g8T7qoMD; Tue,  6 Oct 2020 07:19:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 863D384067;
	Tue,  6 Oct 2020 07:19:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D4FFC07FF;
	Tue,  6 Oct 2020 07:19:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C1B8C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 07:19:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6A572848A9
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 07:19:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mG42g49VJ-KZ for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 07:19:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AC243847AB
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 07:19:51 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id e17so3492153wru.12
 for <iommu@lists.linux-foundation.org>; Tue, 06 Oct 2020 00:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tLX8MUE8fMwR/rmRJeOX+yduwkBmzQAbVy+FfpGJiXk=;
 b=HIhIskfGlz1T10+37AP2R1h/KcV0u+X3rpGLUyAFmq4B10Bv/uTCY3dwqDguRWftSh
 C9ZhZuj4BVKjMh3qL76BuiKqjJIuWT7G+fXtbds68yrNcrv2uKTHKtczcT8U34UeOqRt
 WckPw5KpHd5mW2bn/PRRRCnRHDsNncPM/+7sW5uoMxQJDQEZDC4CaRJgnPz/gRCWE3wt
 5WqA6JOzE2BJWqgrsVLzagF2J6YL2xJE7E5RQVl9dv5M1qpuJbeTtC9AKuXEimpAhPyK
 j5IwGHAPE01pIFhdgzZTHGT2fSc/dGwtRz0ZsQienZWODEs4ZTt7SnFUNcr9NncCzlTG
 X03Q==
X-Gm-Message-State: AOAM530BqiekBjpzrcl89O8mQ/YAmR4g7wNmakISpAq+Mhj1muDWOscE
 zo2U7O9qhg+tJnbxhtMv1Jw=
X-Google-Smtp-Source: ABdhPJwcFPFaKk+kQGjarLysXTsJkvJxJ59r7qmNrLo/3p1ufBJ3CMZyj51pjjHZbxZ26R5kk8lplA==
X-Received: by 2002:adf:9461:: with SMTP id 88mr3236215wrq.307.1601968790024; 
 Tue, 06 Oct 2020 00:19:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
 by smtp.googlemail.com with ESMTPSA id f63sm2746288wme.38.2020.10.06.00.19.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 06 Oct 2020 00:19:48 -0700 (PDT)
Date: Tue, 6 Oct 2020 09:19:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 06/24] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
Message-ID: <20201006071946.GA5759@kozik-lap>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-7-yong.wu@mediatek.com>
 <20201002111014.GE6888@pi3> <1601958405.26323.24.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1601958405.26323.24.camel@mhfsdcap03>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 kernel-team@android.com, Nicolas Boichat <drinkcat@chromium.org>,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@google.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On Tue, Oct 06, 2020 at 12:26:45PM +0800, Yong Wu wrote:
> Hi Krzysztof,
> 
> On Fri, 2020-10-02 at 13:10 +0200, Krzysztof Kozlowski wrote:
> > On Wed, Sep 30, 2020 at 03:06:29PM +0800, Yong Wu wrote:
> > > This patch adds decriptions for mt8192 IOMMU and SMI.
> > > 
> > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > table format. The M4U-SMI HW diagram is as below:
> > > 
> > >                           EMI
> > >                            |
> > >                           M4U
> > >                            |
> > >                       ------------
> > >                        SMI Common
> > >                       ------------
> > >                            |
> > >   +-------+------+------+----------------------+-------+
> > >   |       |      |      |       ......         |       |
> > >   |       |      |      |                      |       |
> > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > disp0   disp1   mdp    vdec                   IPE      IPE
> > > 
> > > All the connections are HW fixed, SW can NOT adjust it.
> > > 
> > > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > > into different iova ranges:
> > > 
> > > domain-id  module     iova-range                  larbs
> > >    0       disp        0 ~ 4G                      larb0/1
> > >    1       vcodec      4G ~ 8G                     larb4/5/7
> > >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > > 
> > > The iova range for CCU0/1(camera control unit) is HW requirement.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/iommu/mediatek,iommu.yaml        |   9 +-
> > >  .../mediatek,smi-common.yaml                  |   5 +-
> > >  .../memory-controllers/mediatek,smi-larb.yaml |   3 +-
> > >  include/dt-bindings/memory/mt8192-larb-port.h | 239 ++++++++++++++++++
> > >  4 files changed, 251 insertions(+), 5 deletions(-)
> > >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > 
> > I see it depends on previous patches but does it have to be within one
> > commit? Is it not bisectable? The memory changes/bindings could go via
> > memory tree if this is split.
> 
> Thanks for the view.
> 
> I can split this into two patchset in next version, one is for iommu and
> the other is for smi.
> 
> Only the patch [18/24] change both the code(iommu and smi). I don't plan
> to split it, and the smi patch[24/24] don't depend on it(won't
> conflict).

It got too late in the cycle, so I am not going to take the 24/24 now.

> 
> since 18/24 also touch the smi code, I expect it could get Acked-by from
> you or Matthias, then Joerg could take it.

Sure. I acked it.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
