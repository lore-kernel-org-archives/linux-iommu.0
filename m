Return-Path: <SRS0=ZfVm=T6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4347FC28CC3
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 22:15:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239A226281
	for <iommu@archiver.kernel.org>; Thu, 30 May 2019 22:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239A226281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D2D5C165A;
	Thu, 30 May 2019 22:15:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A086A15D6
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 22:15:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
	[209.85.167.194])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EEB09821
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 22:15:05 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id 18so5435531oij.5
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 15:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=esfrFMZGksDh8a9cO+oFEVkOyToxeVgjGVajp0t5uMA=;
	b=f5L+XZoYG8HNHtV0g2CR9T3068G099SnvX3nLiJMEVYxJ4bakgQJLkH5uzipkz2Id+
	Hin/e5jH69MWZugDyowVI39hUVOTCA9ROTx3DDgDgJ995ZAI4RcOZhlzPoNdUetDmHFw
	RhcvbhLkbY7ABeNSbLth0jcF/1ND96qFzl6MYJuKIJn+JYRHrAVnTKX5BqktDYX+Af/D
	ridbG/c3I/kaXvTIybniy4cmoH2h7JH1cwPc9c/WIPL7r78JrvmbYpAaLMVYJjzqX709
	ruJ3fB2me2rmdiUBq3ZYhCQVZPqOFGXD0vxFV57MRQDBzGqmJKtFGDXVoGggTy+V5+u1
	4WZQ==
X-Gm-Message-State: APjAAAXrfC8eE8xXArT1sE2Jrv4keZbeFjyzH2V6K6Hy+L/Hl51mhhG6
	/0YGeF9djdXyTOLUeR7swNS2+oea4ow=
X-Google-Smtp-Source: APXvYqyHfzn6WbaVoop6zGRtfB5qfEGdIoFA+UhAStYhxNCOjm7dkLXLLqadsp7dDVTOp2GCKh3orA==
X-Received: by 2002:aca:ad42:: with SMTP id w63mr2358862oie.61.1559254504705; 
	Thu, 30 May 2019 15:15:04 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com.
	[209.85.167.173])
	by smtp.gmail.com with ESMTPSA id 37sm1699471oti.45.2019.05.30.15.15.03
	for <iommu@lists.linux-foundation.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 15:15:04 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id b21so2270383oic.8
	for <iommu@lists.linux-foundation.org>;
	Thu, 30 May 2019 15:15:03 -0700 (PDT)
X-Received: by 2002:aca:ea05:: with SMTP id i5mr3971031oih.51.1559254503293;
	Thu, 30 May 2019 15:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190530141951.6704-1-laurentiu.tudor@nxp.com>
	<20190530.150844.1826796344374758568.davem@davemloft.net>
In-Reply-To: <20190530.150844.1826796344374758568.davem@davemloft.net>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 30 May 2019 17:14:51 -0500
X-Gmail-Original-Message-ID: <CADRPPNTn7onrpyicx_ytdaDG4q3v4t494zYetkHrT808RsOByA@mail.gmail.com>
Message-ID: <CADRPPNTn7onrpyicx_ytdaDG4q3v4t494zYetkHrT808RsOByA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Prerequisites for NXP LS104xA SMMU enablement
To: David Miller <davem@davemloft.net>, arm@kernel.org
Cc: madalin.bucur@nxp.com, Netdev <netdev@vger.kernel.org>,
	Roy Pledge <roy.pledge@nxp.com>, lkml <linux-kernel@vger.kernel.org>,
	Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>, camelia.groza@nxp.com,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, May 30, 2019 at 5:09 PM David Miller <davem@davemloft.net> wrote:
>
> From: laurentiu.tudor@nxp.com
> Date: Thu, 30 May 2019 17:19:45 +0300
>
> > Depends on this pull request:
> >
> >  http://lists.infradead.org/pipermail/linux-arm-kernel/2019-May/653554.html
>
> I'm not sure how you want me to handle this.

One suggestion from the arm-soc maintainers is that after this pull
request is merged by arm-soc tree.  You can also merge this pull
request and then apply the patches.

Regards,
Leo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
