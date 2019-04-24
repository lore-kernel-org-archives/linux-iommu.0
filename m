Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21A7C282E1
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 16:25:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B090621901
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 16:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="U9Blr+R+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B090621901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 46D0CDBB;
	Wed, 24 Apr 2019 16:25:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EB476DB7
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 16:25:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
	[209.85.128.66])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7D57374A
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 16:25:42 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id y197so5943265wmd.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 09:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=arista.com; s=googlenew;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=5P883+nbekL7tkGoEkqJv+mjmmFRCk+81sIxPevrat8=;
	b=U9Blr+R+4kRWjonKLcmrIbYGgw1fNaXecv3XbKQRmt7KES8ymFpCKg1s7/HNxx+95u
	Rm+DKleAVJajAUmPxIepxlZz0F7kT09IaB9Ycgka/b+LIRRwewURgW+BE4OaFhj9J3Zo
	zC80HMz1AWJiw2MtHOtblfa/cnhmWMu68mH6Kj0iktXbDGEeAnAGloI9PVzXR2F2MGa2
	8MqGaNJwzybNPFfEjR/6vsFeJkfYCJ27faaEacNNhq84Ti6k6hnuJgfmDPEVhCb0DtI8
	LK+Qh/shD97mohuWHZNIyDg4gk4p6uKmtJ2xC2Sbp5FKC7llJYh9rkomBYENI9yN7REW
	ttsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=5P883+nbekL7tkGoEkqJv+mjmmFRCk+81sIxPevrat8=;
	b=tZUo9e1FX+Jluxupf/DGMLt6lW2Ao39oeuA6XfoHxXd18qytc46RvQsIZY6c8lzIAl
	h+LpwG1iPs5m9gTdXPyHAQjHiXkGFbCuKB7m4jclO0Q8L7fPeJFB787aPrHSVn8iOlZ3
	EIOmmaPEblkhoBF9n8ky5OQ8P1CD5U0T3iauIYXNWab+l/skBgO3LV9avlBiFXoA56VE
	+dxs9ELmSOHSHXfIG4ZwV0mduoaChmDnItx0VwEsk8pkdYbloLZFIpP8FKJYp5uOzXuW
	EhPQ3bgjKfI03/2y6o71xaW7HjNcu6WcHIMqAmU2o97lXC0KnYQUU5D+Tpnl5ejxzkoh
	WahQ==
X-Gm-Message-State: APjAAAUUcnSTNagLH7HiGIwiIRUSRTdxsUkm4ZbsN7tt0X+4x8qe0/Tn
	yVg0FKWQCIQ1htaMq3J3ChuuSbU44NkpCRi9iLGsbg==
X-Google-Smtp-Source: APXvYqy2H3jvaddz9jIkixllTLWFZ6rQhzjz2AEy4XcTGvNc6vCHzVkyfsgDlVd56gY2gl/qzyYRIeHz1/bIWBWuzUw=
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr4825135wmi.39.1556123140915;
	Wed, 24 Apr 2019 09:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190424141900.8883-1-tmurphy@arista.com>
	<20190424143246.GA24079@infradead.org>
	<CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
	<20190424145819.GA16141@infradead.org>
	<20190424155505.GA6731@8bytes.org>
In-Reply-To: <20190424155505.GA6731@8bytes.org>
Date: Wed, 24 Apr 2019 17:25:29 +0100
Message-ID:
 <CAPL0++7G-=FChbMnHoDfh=SnUW3B3YGi-z7Wy9Dq2D6zzQshOg@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Tom Murphy <murphyt7@tcd.ie>
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
From: Tom Murphy via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tom Murphy <tmurphy@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424162529.DRYdufwCtqzTizEFlaX-Nc-qFTw7UhUPwDxBLSmTmY0@z>

On Wed, Apr 24, 2019 at 4:55 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Wed, Apr 24, 2019 at 07:58:19AM -0700, Christoph Hellwig wrote:
> > I'd be tempted to do that.  But lets just ask Joerg if he has
> > any opinion..
>
> The reason was that it is an unlikely path, as hardware implementations
> are not allowed to set this bit. It is purely for emulated AMD IOMMUs.
> I have not measured whether this annotation has any performance
> benefit, but I find it more readable at least.

In that case I will keep it in.

>
> Regards,
>
>         Joerg
>
> PS: Why did you drop me from the Cc list of the previous replies?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
