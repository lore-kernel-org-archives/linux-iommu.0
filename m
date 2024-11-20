Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4A1A0716
	for <iommu@lists.linux.dev>; Wed, 20 Nov 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103024; cv=none; b=KWM9F6R+h48101iQGvxIWXhW0x0veOdplmdR9Akf8o6kJb87ocUpenTM7i7HDn9FVFe7A8TZyYUR9JAYa0iJZPbfIKqo+BqKowCa9/X9YoD4wYOMVFbWyvcA5B0RLBshM79yeBdLwZzOsqBtzV6py9m9L7cNHVh6XUPJwuBPoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103024; c=relaxed/simple;
	bh=nEv/dRf+P19jkCskJuFkc3Jepej8SWb/o7TpUdRKJOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IidrA9tEI4nEpDkU24fOixI54e+Pygw3cHdO63WqeRX/StotNI2zbS60d5FfBQ4moAUB2tQw8hFkf93rsfubRCYGGgRf8ssGK4ZtePEOKuuo5TFG5MKFXuK9tGTTSF+GBxhOJDQhmWkAvyZB0GG93RZonaJRoVgzuZ9zlYT6kJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmNiTWXa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmNiTWXa"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-211f1b2bf2bso343435ad.1
        for <iommu@lists.linux.dev>; Wed, 20 Nov 2024 03:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732103021; x=1732707821; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cqx7YNoR8/qgldjUyDKzUvYxeEJY+sWQc+hj/9Tl4P4=;
        b=tmNiTWXaTFBeDPU9i000Z2jROe56iqENVWYj2BrCPQciXv/DgqZ7nL7qwpUf190ff9
         oGi2cTJMOmaVXg33iKBu2Br8wu9Bs3giws+6RbovU9VY5wQ9ZJge2w50KXOtjb4UizMa
         er/YOrHXj0/ZEpu9kcZnhJE3WfYaXyPslqoaIqSPa5dVyRcLcE5qEvjDnxitTpwwYk9z
         KWcWGtqhvGCaYl7tb5ae6Ra+MdNwUZ3hFNh4zTeICzI9KuzOfHyOnJKyptkTAq60hXJE
         7Tl4vMtizJG3Jg5a3V0l1IdGgDgnQAmlsFz2xnj72l4fDR2BBjU5z5QUhIfznLS2igUw
         UTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103021; x=1732707821;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqx7YNoR8/qgldjUyDKzUvYxeEJY+sWQc+hj/9Tl4P4=;
        b=HqqnMEF/pQDisZuzDokbaCSsCmYGJk7y9N1ggGUnayay4QMLMv77GsLCxDoExcweQR
         cppiyfny9Rlus01sxUkEco7mkCO/BcUiMcJW1CxsODZ2PJDm77Y6Xgev+qNd+yxiubck
         DMkWm2IFbTH+h/v/bzMeDXbke0heKei1B0RMbSFZUaVUZf0xth8xGi/VuYgpvbpBaMJ/
         hnPrqUdwxQZ7nZIF6qcWAJcbQtyiijrjWg1b7W9CraEQ3f+Zi2IREhpHEWW95b5+PJEy
         z10gc8tkIM15+YB2oVKQLdr09fNnyEZa0beSM3/KPL6jeV53XKh8nR/VscWRFLRpdtWP
         2lYA==
X-Forwarded-Encrypted: i=1; AJvYcCVEA+LAJM885S0YRBGl3HzhbvlfnsEaGQon8wfVZl5wxzJbtiKGdfh38u49ojxv3pfIh5eWbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLS8OCd6c+isY2wDFMh4L3q6jPcVjL2ZB9w6C6M3tyiGpKkS2f
	Z7j5CyuFS0ZGSI41HdjBOUl8miV/CiGtMau/CUHGMkF1YDUUUUXe/Vtpe8I0Eew5+rAyFP6iUwI
	Bo5tT
X-Gm-Gg: ASbGncvHxR9Bsd5oi39+N3skTLwINVqtRu0m+R6c4CSdmgu1o2Ttl1owVWEWmrP3rTt
	CdHyzEWQiFu2foJnzjihDHwlQ4vI6GBbK3u9c9E4/qwVS5+1s0u4lurzQhWxwXzVg7Z1wx7S2UX
	McBBF37RwfigMLZY4AsTI1V0PuxqNqyRC1HiN4crto4k153hWEtCaNw1ZUrMg0kzNe0ZOYrxOO2
	VuyPwswUFNtAryy+0g9KdS6oLG4bQCTHDFQ7+XQ/XAFqnh8QvNZvJd8bcnm7loFg59iuGOyE7Cq
	xcO08vj03QM=
X-Google-Smtp-Source: AGHT+IH9pRcuBVRrkkP7QyqJyHh1UMMFC01WuIDJFySHZ6skjTaqV527xorgT6Ghy8CGcbXf+Qo/Kg==
X-Received: by 2002:a17:903:18a:b0:20b:8915:96a9 with SMTP id d9443c01a7336-2126e190129mr1631135ad.29.1732103020802;
        Wed, 20 Nov 2024 03:43:40 -0800 (PST)
Received: from google.com (104.132.143.34.bc.googleusercontent.com. [34.143.132.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befea2d7sm1465110b3a.182.2024.11.20.03.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:43:40 -0800 (PST)
Date: Wed, 20 Nov 2024 11:43:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 0/3] iommu/arm-smmu-v3: Parse out event records
Message-ID: <Zz3LZaYh_-Ut-mMQ@google.com>
References: <20241112083018.1662104-1-praan@google.com>
 <CAE2F3rBqPF_POHSdeRahgd+ew9tD37iq6S8M=9Sj0Br6pe5e5Q@mail.gmail.com>
 <CAN6iL-SwmwgiyhvCkGV__Q4D_K4TRD+6ZD1O4YJS2qtamW1k_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN6iL-SwmwgiyhvCkGV__Q4D_K4TRD+6ZD1O4YJS2qtamW1k_g@mail.gmail.com>

On Wed, Nov 20, 2024 at 12:24:43PM +0530, Pranjal Shrivastava wrote:
> Hi Daniel,
> 
> On Wed, Nov 20, 2024 at 10:15 AM Daniel Mentz <danielmentz@google.com> wrote:
> >
> > On Tue, Nov 12, 2024 at 12:30 AM Pranjal Shrivastava <praan@google.com> wrote:
> > >
> > > Enhance the arm-smmu-v3 driver to parse out useful information from
> > > event records into a structure for better event handling & logging.
> >
> > Hi Pranjal,
> >
> > Thank you for putting this together.
> >
> > >
> > > Some sample events, powered by QEMU:
> >
> > > 4. Translation Fault:
> > >
> > > [    7.586428] arm-smmu-v3 arm-smmu-v3.0.auto: event 0x10 received:
> > > [    7.587012] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000800000010
> > > [    7.587504] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000020000000000
> > > [    7.587986] arm-smmu-v3 arm-smmu-v3.0.auto:  0x00000000fffff040
> > > [    7.588745] arm-smmu-v3 arm-smmu-v3.0.auto:  0x0000000000000000
> > > [    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received: F_TRANSLATION
> > > [    7.589219]  client: 0000:00:01.0 sid: 0x8 ssid: 0x0
> > > [    7.589219]  iova 0xfffff040 ipa 0x0
> > > [    7.589219]  Unpriv | Data | Write | S1 | Input address caused fault
> > > [    7.589219]  STAG: 0x0
> >
> > I find that "Event 0x10" is redundant and recommend removing it. Maybe
> > print just "Event F_TRANSLATION"
>

I agree, however, in the past reviews [1] we've been asked to keep the
existing log "as is" unless there's a particularly compelling reason.

> 
> >
> > Not printing the prefix "arm-smmu-v3 arm-smmu-v3.0.auto:" on
> > subsequent lines appears to be inconsistent with how the raw event
> > bits are dumped. Also, I typically run a command like "grep
> > 'arm-smmu-v3 arm-smmu-v3.0.auto' uart.log" while I'm developing smmu
> > driver code, and with the proposed change, the grep command wouldn't
> > print most of the event details, because they are not prefixed by
> > "arm-smmu-v3 arm-smmu-v3.0.auto"
> 
> I see. The prefix isn't getting picked up because I'm trying to print
> all the lines in
> a single `dev_err` in order to avoid other logs inter-mingling with
> these ones. I can add
> that if we are okay with using multiple `dev_err` calls (i.e.
> potentially allowing other logs
> to mix-in).  Otherwise, let me see how we can manually add the dev_fmt
> string in the log.
> 
> >
> > The words "client", "sid" and "ssid" are followed by a colon (":") but
> > iova and ipa are not.
> >
> 
> Ack. Will fix that.
> 
> > Can you put everything up to and including iova on the first line and
> > the rest on the second line?

Finally my email client is fine. 
Did you mean something like the following:
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Event 0x10 received: F_TRANSLATION
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: client: 0000:00:01.0 sid: 0x8 ssid: 0x0 iova: 0xfffff040 ipa: 0x0
[    7.589219] arm-smmu-v3 arm-smmu-v3.0.auto: Unpriv | Data | Write | S1 | Input address caused fault | STAG: 0x0

Thanks.
Praan
 
[1] https://lore.kernel.org/all/08498356-d892-4756-89e1-45b2654faa42@arm.com/#:~:text=safest%20to%20leave%20any%20existing%20%0Amessages%20exactly
