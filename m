Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1598F22A1D4
	for <iommu@lists.linux.dev>; Sat,  7 Feb 2026 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770430325; cv=pass; b=oTo7NJO1yZLcVDKuMFwir1rkHF6MdRnbqCWbsRPSJ4IS5XGTWGAYhTtmU+ViGbmlnQ4XBYQJO22sywuGMIZXmG4jIHxMHJeLFOjyVfEezdHdAO7mIuLX47OiC2O4jw9BkzZ6ULy+j24ZDbBdOVzPG4wOP/udppocx2oknIaswhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770430325; c=relaxed/simple;
	bh=H8ygkU9hCJhnugRPEnG3lPWgCrbq+0GO3cjHhz/6Ncs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZKBLsfV/9lzFz/59J4vIxqQhfeFzJ/RDCbKUXBASGhTFK5IQXJIrNqm53WinyYxyeuSkGtCDpUkF5/D4r2WiRRDfhy57v6FgGi53yYazE5X49eb8By4gFwqRJCWsyBsIP9R69Vy4QG1LrDw51uyIQgWzWd8vMFkC9d4dBRVZ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=U4l026Er; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U4l026Er"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b884cb1e717so85864466b.0
        for <iommu@lists.linux.dev>; Fri, 06 Feb 2026 18:12:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770430323; cv=none;
        d=google.com; s=arc-20240605;
        b=BmJNOCiRZB1MWJbe0cxWcUotLHpoZtlMSaaSPFskICYjKQiVzow3S4q8n+ozYPWyUR
         pjoGCmiJhx3EYujTKjquR7qTrMM/DhWt4igaA156M0jsvR2hg34WJ24ZRApj4Z7fhnUQ
         Yy2BwHukthnDu8T3N4hwfRYxD++Qq1qC3JrPyUqu5AOWcyEKCAx1MkDs5sYtXDu2oLhD
         bTtH2387KqPk8rRpDQMYniDUz8YGXEPfvzs1bWGkZyVphu5Y5WfmZz/bMkQfBzUbunE+
         iOfRv3mPQfiycDIFoOxwH3myCAzpKq8rqT9rT0cawpZlHuJslEJXGa0/qzdY+B9wQUxG
         8q6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xVXJfBkOf++utzjym33J9FgN5u0L0gqySOwPjSjRi3c=;
        fh=LUYJ/pYOW3+WuRRgZYMBDAGs9D6n6ucn/cDVHMnZU5A=;
        b=Xhqbej/EG3XDACXpNT+PRRFM0HdruTcu0feMhKngc454fFL1ogz9Ho/ITibNS/JL15
         dOTILg0czSAAN3Vok9UW7vcRg44/y8Cw15IgFa82e4Byf//QFYG7/dcOzGX1VShhNGpB
         q0dTpZVqdFKpPEVGuDeJBqcaF6iBft0kaiCOM4xPC1AgMvsAzvhMNGw5y6h2I4hd1czM
         feeiOc3PMUGF5fPwFiHND5PTTXin+YdBoD4WdylBBKk12Aj9Xe68hrWSax1KCNA9AgSM
         LyQbXe43pgYIJkVMUrrtNGixk0t8fB1VGPXTmvGIIk6xm+azpW75gTetd3ixe7bq6ncl
         Vc8w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770430323; x=1771035123; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVXJfBkOf++utzjym33J9FgN5u0L0gqySOwPjSjRi3c=;
        b=U4l026ErYESgVq02FMhEFsyUIrkCNFyUyyzw6TVeWZtCjk/zH2pociQuaYPNfyufRJ
         fF5FR13+qqWeWryDV1kxBaZ7/zARivWxz5O19Lc5Z2G5CNL13DxyKcO0lnN/GdHVnosh
         +6rMXvWl4ix5LRoZ5KlwOlOXu4e4WVKwCgsh2jrnKKI/qUOHx1519xWw+uq7oBQLr2hf
         CZMyILtSwGmImfy90xMUuOX0qnAp8T4cw8y22iAbS46NLWPwaNXZ2W4WmXcS/4oTZEsn
         OBHPtDZzgcxdGdLKFx88snnG60ZNdUK54e0rrv0Q7LLkH3ZJqjsSMlg2/L7h62aZ+FdP
         K4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770430323; x=1771035123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xVXJfBkOf++utzjym33J9FgN5u0L0gqySOwPjSjRi3c=;
        b=Z3XMcsiv9mNIWdob7p3wzPi3lafGFcV5pijEny/2VSHr0jA1OvqcHmc6wZlFHaT5aQ
         5GCfjdeavMbkMFkONQrAFTlGWEXYnaaUdjCEDB+uVzQ515744x133cLyCJn4/fmXXDm2
         BkgYRcs34bvpfgwg6iamMBkYVasHchExstTEgsMu/kuU9VvviAUyyAw3obpi/hMahKM7
         GwNVE0WoMcl3fF6mfp7Hn/rnS0R2NnBG7QOIXVYTFCEZGRaehLoT9M8xhSRNtyjhuBCC
         BSw8lvU+zvPC/hS3NLpyGHhR97erBcKrMYMETraUl5UMlJvDlgxiJpCYWsEqJDh4s3x+
         8Gmg==
X-Forwarded-Encrypted: i=1; AJvYcCWD2UnA0LA102YDETNGcUTkGIEDSY6QsfcyZ52i5ABPquui/m53v2nBbrZvTctT8ev4r5Paqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YySx6f2SdXDQQUcNIhZin6f8rjndMP0m0hNFzpDJ8CQ/AL/4Rk7
	RjV6esgCdMyBES5yDvSKCDhy9kUOfa789XpGaTUJgzkI0BByvHALslxOvJpvyMNwcOJNeL9y2uq
	ftAJ6eBoFAyhOAxqtgmUhMtEiCwOFvQDzn4DUmV22NQ==
X-Gm-Gg: AZuq6aKNKBoSD9LMGXJdYRgP3P3Cw7kZd7cgJvcspDc5kH3r/Q6j4uWrOAl5WXBnU+W
	ue24/o5yQgwWH3X3kMZwHpbBPXY8OXn2vpguSTzD1VOSaOfZ5wKyAQ5HHw+ZDc/O6s/D66pUUxG
	yzaKBO1M1l//k3B92hEeeX+aoN0Jvp9HHrFcdCuqIxWOXDEsu4rD5Q7w0OPAeADyV/LZI/HxKSE
	6OE3wFesNSqgYkgHhXt2tqH771XMg4oufJaOcKkFZqxVb+pPpKEitf9vj9Fl8ZlF/rR32aT5N0m
	GnLhq6PW
X-Received: by 2002:a17:906:d54e:b0:b87:2abc:4a2a with SMTP id
 a640c23a62f3a-b8edb7e7fefmr270858966b.1.1770430323440; Fri, 06 Feb 2026
 18:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
 <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
 <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
 <6C65A3873186B07C+29da5dbd-ed27-4ace-a5ca-355b3983d60c@linux.spacemit.com>
 <zzbwkazzgeovgmbvg4qnibipzsldqcjnw4axnxlamhgvcld4hs@4m4cc2ctuuvf>
 <752514AD54FA2A1B+513d6894-b3bf-44f3-bcc1-7d30f2642cc2@linux.spacemit.com> <xukccsqgwmagqq5egx7i4op6nfot3t3lusnaso4pfzcq5h6bfz@adsm5nusnocx>
In-Reply-To: <xukccsqgwmagqq5egx7i4op6nfot3t3lusnaso4pfzcq5h6bfz@adsm5nusnocx>
From: Zong Li <zong.li@sifive.com>
Date: Sat, 7 Feb 2026 10:11:53 +0800
X-Gm-Features: AZwV_Qjm6m6hA8715ry8OfD2Mr5pGoAnS-0dMwS1leYT9MosL-HIb3AQrdVJAok
Message-ID: <CANXhq0rFuvfcYRew3ZDWfNOrrAYo01OqPzJ5rbRZN6eS1t72jA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance monitoring
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Lv Zheng <lv.zheng@linux.spacemit.com>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>, iommu@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org, 
	Yaxing Guo <guoyaxing@bosc.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 11:09=E2=80=AFPM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> On Fri, Feb 06, 2026 at 11:42:39AM +0800, Lv Zheng wrote:
> > On 2/5/2026 11:23 PM, Andrew Jones wrote:
> ...
> > > Since Zong Li's patches were already on the list then your serieswoul=
d> at
> > least discuss them in the cover letter, explaining why you've opted
> > > not to adopt them. But, most likely some of the patches can be adopte=
d,
> > > so those should be extracted from Zong Li's work (with authorship
> > > preserved) and based upon in order to respect that prior work.
> > >
> >
> > You can see we have contacted each other in community, and decided to
> > cooperate in this way to honor his contribution. But final decision is
> > left for the community to decide:
> >
> > From Zong Li:
> > >> Of course, if the community would prefer to go your version, I=E2=80=
=99m
> > >> perfectly fine with that as well.
> >
> > We respect all contributions, We'll add the link in cover letter to the
> > follow-up revisions, let me know if anything else should be done to the
> > new revisions.
>
> Just do all the communication before posting, allowing that communication
> to be summarized in the cover letter and in any appropriate commit
> messages so reviewers know what's going on. Also don't forget to CC
> anybody previously involved to ensure they have a chance to chime in.
>
> >
> > --------------------------------------------------------------------
> >
> > And let me describe in details to compare the functionalities and
> > addressed comments between what is provided by Joey and by Zong:
> >
> > https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
> >
> > There is no missing functionalities between the two approaches, I also
> > checked the original Robin's comments, let me describe them in details:
>
> My concern wasn't whether or not Robin's comments were addressed in this
> posting (that's important, but not what I'm talking about). My concern
> was that Zong Li's work wasn't addressed in any way, so appeared to be
> a chance for duplicated efforts. Indeed his reply [1] indicates exactly
> that and even that there is a third patch series being worked
> independently. Please work out who and what patches are going to be
> the focus going forward and describe that decision in the cover letter
> for the next revision. And please don't forget to CC Zong Li and Yaxing
> Guo.
>
> [1] https://lore.kernel.org/all/CANXhq0oi9nE7ffLGsz5j8GnC1UDTD-4bE4cantRj=
W2fXHYrjHA@mail.gmail.com/
>

First of all, I apologize for the delay of the PMU series and any
inconvenience it may have caused. I also really appreciate Andrew for
pointing out the upstream culture and consensus.

My next version (v3 series) is expected to be sent out in the next
couple of days. It will pick up all the suggestions and feedback from
the previous versions. Apart from that, the main structural change is
that the PMU driver has been moved under drivers/perf/, which is
something that has been mentioned repeatedly by several people.

To allow everyone to review the major changes in the next version as
soon as possible, the custom event support will be split into a
separate series. Its overall idea will be similar to a typical
platform driver, where vendor-specific PMU events are defined through
driver data. More details will be described in the v3 cover letter.

Additionally, since I did not follow up the patches from Lv Zheng,
Jingyu Li, or Yaxing, it is very possible that my v3 series may miss
some important features or fixes from their work. If that is the case,
I apologize,  I was not aware that those patches had been posted to
the mailing list, which is also why I did not respond to their v1
patch series in a timely manner. Therefore, I would really appreciate
it if everyone could help review the v3 series and point out any
additional fixes or feature support that I may have missed.

I also really appreciate everyone for always helping to bring us
together and keep the discussions aligned.
Thanks

> Thanks,
> drew
