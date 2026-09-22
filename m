Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4F54B1A7
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085203; cv=pass; b=sPde6rQy278smc0H0DFXzPAyuJqjw6r4xf00qHsYuun6eLhLCXc+9sf20rJ4A8Q+819EIoykge62ZUZTtjuFMz4fcvELrBDFmDNOLMSbvcF3m09Lay4e7cZCPCI4/YkSJ82Lp6seguvYfcb9rO02nh5nWMzKHQr9a2cQN8tQhx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085203; c=relaxed/simple;
	bh=0hurBNTkrVz1B/9TW5ipWegr4/ZEEZE2GB3faJsOdT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rveZ5qudHfNHc8PBETWiX+y3rAadG0G95jfJrv4JAmujlWEkQStxLeAu0M4wYv+6GPJY8Xjy4UrKnAFtmSj4H4uU8RSMPW9bnS3HQegkUl3VMWA/YZWkWF6CYywSCOvPZeTRpH/ImlvCgFohRUbX0V52SqvfmOo02tNWPRyIxng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJfQrXKj; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJfQrXKj"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a985fba28bso5089703a12.3
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 06:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790085200; cv=none;
        d=google.com; s=arc-20260327;
        b=ZG5u11jyQnTaZFR/7/YYGGmJzpUq1DzhAtCoN4qQxtWcevVKuNvqkk4GEbNl+Js1Pb
         9M9p6jF3F6pn6fRspUwIt6RZnCltcKs5fgkdQdkDBMWZfbKtlq5s5I72RX+XiTMITpBW
         L5uKqNw8VG4HD69oIusXS9XA1P8N5b2QjxH+il8rwEHslKlHGPDCAI/kSIDLccFpexcE
         YEsOey3JOQUyxsVJghtVG0BBDvIX5hXxR8hXx40mDkLAZNPfmxXwMdcJcn0PHqflP1ok
         LozJtwMZZdhAyLkBPoE8x0Ix4MXyePTQMSCFo2d8BlsJUfmWaRRX7fGPuO7BYMgAyHdN
         2oPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=awCRBzfBSO0cm9zEvmZIeCCRXLT0QzBOpw1tpjmmlbQ=;
        fh=bkbECWSFozWEZlU76xQPg/IFQ1PDSXsyL+QvGLxvZL0=;
        b=e4PGMhkwcz0cLT3p+qDJFAPbgEroGJrn2LSa0kmqyqEwP1t4Z4P4PCnwz3QA7ORZau
         IwClRw3buB3M5wg5TUBzH1h4V/ol6N0969xPhJZtUd7xW5AToo/0DBC++4fBKtBLhJCZ
         yM0H7/cahdN0kNrN7vpC6iUqiWrko+9U40uvdn1U2MQIZSvYrrd/TvjI2UUPndZ1upGR
         tCMXXHdrcHq2J0DspvDpXJMI4ELyhurLjLBiOjnwgdUkDteP7tX0u7w4uw03V6EBB+tz
         PDmyQXetoq5GXZ+rdwBW0H/HVtJi2kbtCJo3/KKgX/aaUGPy0n7mpf0Q9EwJ09eMvpIN
         bKqg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790085200; x=1790690000; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=awCRBzfBSO0cm9zEvmZIeCCRXLT0QzBOpw1tpjmmlbQ=;
        b=xJfQrXKjUWONG38womQya5smAp9gsRcpsxsyRwgvpI5Dp7ZDiAkkzhfhHut7wFte5B
         vQdLlY797vE0NiHcp7Y35lRyoX1wo+MTiIN/rdxz6CfM3J8VNvty72SPio8AFDVBzwtt
         BscQFUVPPVojZdoPhHUwDSyS6OYnVOUkLIZCS67aPx1uYCD1YPVUGkaoqPaYqjPZ3igp
         AqQTgK3EhsTKkNywF3NQRTaobCOmXVWantfAtBgIo9TiOY/5HUx3kLdx3v1v1zanCfet
         kCeqGTws8GhEDy/4evDN5CNx8PM9QuvWGdT+culDnAwwW1Cqvu6e2RPdBe03ClsLJsRc
         VDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085200; x=1790690000;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=awCRBzfBSO0cm9zEvmZIeCCRXLT0QzBOpw1tpjmmlbQ=;
        b=CuQTqAAf/C9bV0jU8UWBbQrdOdWCaoVD+TGLDQHIilT7Ng5zL1FzCChte5zsIBkvLY
         j29XGQ7duzO0aMAX2hjKdvaIGUeyCXaTMeAaPgyka1AlP2opk6Ce0XCkGIr69a7iXfAO
         AGskGvwUfgzHlmwiDSrxvjzHSU8lVBxrg8WYa1TxjZWkIBLXXQAPVGE6Lfbph9colKMd
         15QQevNqcSpWJrKZ97SGDoNTSr5hdS1gEP2ZPv49Wp6RFQXg01R8StISYON0g+CunHrb
         t4slVhsJNe0shhhj44tnREr7Y7dJWhyrvQaC+YXvbtuFNLs1Mfwm6b0hdHAG8XBqqNH/
         aloQ==
X-Forwarded-Encrypted: i=1; AKwUvBz2pwpxCBv8Hbz1Z2MJHkyGO3siYxwYaaJJsL/LMj/dZrcrIydYT9J8iWCg8V8eXag39SkQVA==@lists.linux.dev
X-Gm-Message-State: AFuF++mYxUfs7MWzJkQPT7gxehHFLHH4QnTGHgt7n6KPCLjBOJcb5gY1
	OQb9M6lPApTkzijmiPNg35EtI65NEk6PQGSXtj49QF8659OW6D8BP7du3GevCkuuefBHnYb1FZf
	AYzne2n/s3Xh08uSwGozo5CvP5rx6nlYBw0qL2kDxhg==
X-Gm-Gg: AYBFou2adWFZa0YqDo7ULKK29bXa0N5AQifP9RGQudzUYXycFIiQ35xA7FQr0tSA1Jd
	/Vm1MdHlA4N5HBhiRNiXr7qNdTMLtQuDxhWJjzEhWfPMlayoRXnldZqjauaWpyQ0N2c+PVpk3Tp
	qLss8kKLhpqsFHFYa1NlDjjhBp1L0klqlhcT/qj6dSIzMqdZYRphOoYfA8MGT6pLPg0vAEs/Asu
	Tlpmnkzncfhee1BrVDwmmHah4BoZgPzoTZwMALTWyG6u95XEEWzDr8gz9PnPpWl+zP1FXVNxhru
	5ENgGddHx3xmMubpP0pPWVrY+PLkROLBsI3OGh69ya3ikTUDqmREEe3CLKBtMCWh3x+atHV2lBu
	aEgmP9WAqQrvq
X-Received: by 2002:a05:6402:20c3:20b0:6aa:9210:262 with SMTP id
 4fb4d7f45d1cf-6aa92100342mr3351155a12.22.1790085199929; Tue, 22 Sep 2026
 06:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <aq1sooGCYUiWbhMH@p14s> <aq453yukMHiNb1jp@bywater> <CANLsYkySF+eF-FURnnT6UJv7P5Sg2HdfMSBZnZy_BLyCMvuofw@mail.gmail.com>
 <arIfj-1Ji6HEBHLJ@bywater>
In-Reply-To: <arIfj-1Ji6HEBHLJ@bywater>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 22 Sep 2026 07:53:08 -0600
X-Gm-Features: AcwNN1V0zenE0U1QivuzVoqHQLJIIYIxl9SSuy2ocYOHZBqajP-1AfG4uh0OqKk
Message-ID: <CANLsYkzaxwx8NJAOki_wkzauL68ourd12qF8PzzVKW++PJXZfw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] remoteproc: add support for any virtio device
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
	imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 00:29, Francesco Valla <francesco@valla.it> wrote:
>
> On Sun, Sep 20, 2026 at 09:31:11PM -0600, Mathieu Poirier wrote:
> > On Sat, 19 Sept 2026 at 01:33, Francesco Valla <francesco@valla.it> wrote:
> > >
> > > Hi Mathieu,
> > >
> > > On Fri, Sep 18, 2026 at 10:53:54AM -0600, Mathieu Poirier wrote:
> > > > Hi Francesco,
> > > >
> > > > I have started reviewing this set but given the size and implications, it will
> > > > take me a few days to get through.
> > >
> > > I'm going through the review done by sashiko - would you prefer me
> > > sending a v2 with the trivial errors already ironed out before doing
> > > a complete review?
> > >
> >
> > We can wait if the errors are trivial.
> >
>
> Not all of them are. I have been a bit to naive about the bounce buffer
> management w.r.t. what can happen if a memory area is not specified and
> I will need to rethink/rework that part.
>

Ok, I'll keep an eye out for that.  I'm already halfway through your
work, so there's no need for a new version now.

> Regrads,
> Francesco
>
