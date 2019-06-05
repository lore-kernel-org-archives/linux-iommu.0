Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71343C28CC5
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 12:57:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B04206C3
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 12:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQwC6cZR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B04206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 25DD7B09;
	Wed,  5 Jun 2019 12:57:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 105379F0
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 12:57:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8701519B
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 12:57:31 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id h10so5619556edi.13
	for <iommu@lists.linux-foundation.org>;
	Wed, 05 Jun 2019 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mNwmQAhzOwQjP+3QJ9Qyx716sV+MvZek24hV7EIWuEc=;
	b=MQwC6cZRlpJp8S8gEeUy0yt/YY6pRXiNx3qhhdxZz9mLO9tFistVEu7HCQyTCKskfV
	QpilpgNDrSsy0SJeh+jsSnNea/tjgHTWFNws8h4ueQKU5kh1xYGg9Q1gyK3vv6zxAnHw
	sU97TDHpfGjxnf2hgH7zC8Dfg2zLXJcMhil+tT/laN5pH5eVwjNqHpydN74VC65OcIlw
	L9iWQeysiJXDLU7R9xRH0J9WW7JcL5/NzkTplwLoLIL+Gsgnwi27Fh8B4Fb74VRhZPAc
	I5l9I4aOJVWnaQQ8y39Ju17r1ll91KBxJFYq3FZblaRbSz0Nr10NIb77Pp/mAXG0FHCq
	9YUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mNwmQAhzOwQjP+3QJ9Qyx716sV+MvZek24hV7EIWuEc=;
	b=lYACDtzUMN1/98N3yHztu+vXp1MI0CsbFU6JHul8jRz7scek8rZhA7w2ppmO7hMwoY
	h2IQMa7Zy9aEGoUs5FTXB/pKCPgWq33YTjGLO35lKYha2qjHH5+Y1vB+4/s+xtI7jxyl
	68MbEFx/y+JwKOzUdzA/b40Bu4VsfEJ0CqApWUwYtnDB4xqOmp0K9XFj9vqjHJ+07eu7
	QVdDMI0UewYLhbJ5c6cyEjoAg9nkWJAmD4546YZvXwf7HxHBx2GsU1OkaWvzVu4QHDT1
	nvbJmGZVGqOndQH281utE04RBD99PtALjLlaNmyec1TnGYAkSMmTGa6WgIjm73JEquBV
	EW2Q==
X-Gm-Message-State: APjAAAV8cvAMFBRxEcsYcdxVyxXdTazKIyMLB6sZcx34YTpoaid5Wf67
	ooA3u8zmGN+XhOjfYim5dKxYevpsUSzT1mvm94k=
X-Google-Smtp-Source: APXvYqz1vxq2jyAjvwPKAI30zCoOlIgNefzBtyYxFxTl0wx0mcMOz/q43eVDTS2eLaVvoero3Qx6Gl/7d2TUyTJ/Pns=
X-Received: by 2002:a17:906:85d4:: with SMTP id
	i20mr20270754ejy.256.1559739450124; 
	Wed, 05 Jun 2019 05:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181201165348.24140-1-robdclark@gmail.com>
	<CAL_JsqJmPqis46Un91QyhXgdrVtfATMP_hTp6wSeSAfc8MLFfw@mail.gmail.com>
	<CAF6AEGs9Nsft8ofZkGz_yWBPBC+prh8dBSkJ4PJr8yk2c5FMdQ@mail.gmail.com>
	<CAF6AEGt-dhbQS5zZCNVTLT57OiUwO0RiP5bawTSu2RKZ-7W-aw@mail.gmail.com>
	<CAAFQd5BdrJFL5LKK8O5NPDKWfFgkTX_JU-jU3giEz33tj-jwCA@mail.gmail.com>
	<CAF6AEGtj+kyXqKeJK2-0e1jw_A4wz-yBEyv5zhf5Vfoi2_p2CA@mail.gmail.com>
	<CAAFQd5Dmr+xyd4dyc_44vJFpNpwK6+MgG+ensoey59HgbxXV6g@mail.gmail.com>
In-Reply-To: <CAAFQd5Dmr+xyd4dyc_44vJFpNpwK6+MgG+ensoey59HgbxXV6g@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 5 Jun 2019 05:57:16 -0700
Message-ID: <CAF6AEGuj=QmEWZVzHMtoDgO0M0t-W9+tay5F4AKYThZqy=nkdA@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] of/device: add blacklist for iommu dma_ops
To: Tomasz Figa <tfiga@chromium.org>
Cc: freedreno <freedreno@lists.freedesktop.org>, devicetree@vger.kernel.org,
	David Airlie <airlied@linux.ie>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>, Doug Anderson <dianders@chromium.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>, Frank Rowand <frowand.list@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
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

On Tue, Jun 4, 2019 at 11:58 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> But first of all, I remember Marek already submitted some patches long
> ago that extended struct driver with some flag that means that the
> driver doesn't want the IOMMU to be attached before probe. Why
> wouldn't that work? Sounds like a perfect opt-out solution.

Actually, yeah.. we should do that.  That is the simplest solution.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
