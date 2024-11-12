Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9480B154456
	for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399166; cv=none; b=BEOg0B6E8TB3GU4pw57IWkOi9aUhtGtlrzLvMyUx570LSG6MwrDTxU+D9u3ha8qSkIb+/dLrxhEj2tTFyTVCfzoh4VPyWEJj7B/5RfMOKIjjmhslbSYw6STCFHCYPNbzgrU9fTqEMCoXFH1vHkjGbGl+k5oItGrfoxHFSKKu8os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399166; c=relaxed/simple;
	bh=k40QqhZ5G97poaY216R7Kfd01nVpavpRkjUuQFp6t9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T70eVFXwHqAdtwFM6L/1Xwz31z+ZSxYdn1ChIwSfO3BrON8P0MVIEii6QovOZh9Yb39aZln84fzzNjrJUD9RRtemeGX7n/R6t9ezAKbVBFAyKChRh+aFs3Bs/f+M5K6IxyZue41G8HhOFzkeAr0Sbzx7W+hrUOviunL4OyLs0XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pF9zrL2v; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pF9zrL2v"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c87b0332cso97445ad.1
        for <iommu@lists.linux.dev>; Tue, 12 Nov 2024 00:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731399164; x=1732003964; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gCRotphTz8QtelEb9RYKzAao9LuG4eKQ+fqKGxsOJ50=;
        b=pF9zrL2vph91LT6xCN6otl86OWhS+ojL8Diy7bU27UqrZ+bA3VKgKf8SPSmhPbDCTG
         lBXBA2VQ5YPzD3cn7jSvHhtZAJSYXvG284G95Pr0cJneXbGaN9OkV3TwJInBMDD/hwLs
         5mCwstEgqhuVN5LZPafhFZuSQqnoGSF0iqoQQ4wYnDsFvyHNCZ59SszimJVWr6uucKPi
         uOCElAgFhK7iTBjrI9erHQHJWJHCsHybCLs5/phq1/RtKk8YwozN0Vwvh1JdC2NFNm84
         nzdQXV8NOXjTg6baM08mlliCsPJEcAEHXVzzZa1pp0s3814gh80iBrwFCOm09AVxgEy/
         f5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731399164; x=1732003964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCRotphTz8QtelEb9RYKzAao9LuG4eKQ+fqKGxsOJ50=;
        b=rDi4q9wDEsJyhVmkg/+tutiRLizvtFibmyLZ5KcEZ17lAFFeseTsxTHeRlvn/wug7h
         XYIw54MaKiPV6KCeIksB1FWzvSEoN6rHaKXTbYeU4c2Jj98cUiASeoTIMkpSgA55z4wp
         17dj1qcR8/IBI0/C4FkJs31Ga7h9rB9PpfLq5vkOEcw8+vwMxjOFVnp2HL/TgdhxILWL
         1Czs6ZaHAbLH2Vg99ECziOUDuCBCxpF1mwu0dEAm9ef/P3jIjyHJ8dznwKdcyeWB5Jf+
         uDZ0d0C2ZdQeJ79H4SMW34hdBG9UjfS8ycmFtufFjgXzcqXW9Rh4KllOjNDFZSlHIfE0
         YTqA==
X-Forwarded-Encrypted: i=1; AJvYcCXKTtsf4EhcvOdioqvvITS0HZ3vWVgp4B9TONkWgBROHO+ocSn6/KEkkM397ixS3rEGXXhYYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLv4jsfsHekVuy6Gg8ateGllHN/jkV5E48w8zW46CxvqnIUxtu
	8iV9rp6CWcxvpyGD4Uo/12nys49lEnPaD2937nmHQlZc2Brp4K9vD+ymDs8YRA==
X-Gm-Gg: ASbGnctbvrX3FIGcRruiAoCk1zwSXM/g0eWEWD9pnfQrUgQygPE5fFbiUeD7eWLi003
	TVd7mEpf5yBkrcBWqL8PMGTcmzw6bcNrcyujpBxpoI9fcrfGaAIKwbxBu34ACOyoFO4V8IopWXJ
	MhAI+oyNerF8iIsT2rVgpn8fW/YYx4QnZ+WqzVplHWk6LXJQZ2gH3Gs6fJ4UOtF1xLHZeda2FHW
	wwdaKA/yxnKIggNEjyBmB5uOtBynLbWQhDc/ohcsmvwPtwhDJFMWZfwSeupAFjopNgk8qmIieJl
	L5fo7xE2erQ=
X-Google-Smtp-Source: AGHT+IGVu1aBEIxDRszVTpE9GzSD3swgLnkFQhbNwCuNXPpylzu0LSgkeW3+NhM2lavv8tPG582Wzw==
X-Received: by 2002:a17:902:f551:b0:20b:6c3c:d495 with SMTP id d9443c01a7336-211aceef58dmr1100545ad.25.1731399163622;
        Tue, 12 Nov 2024 00:12:43 -0800 (PST)
Received: from google.com (146.254.240.35.bc.googleusercontent.com. [35.240.254.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5f948a9sm9909473a91.29.2024.11.12.00.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 00:12:43 -0800 (PST)
Date: Tue, 12 Nov 2024 08:12:35 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <ZzMN80bLTnJPAHfH@google.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <CAE2F3rCZALbQQUNeaAqShgXz6UNnSQAagqE7RA9kAewBFJNenw@mail.gmail.com>
 <ZyzVTG8ffcFD8YFR@google.com>
 <CAE2F3rAL=a43NNK30omCyfKZR=_Gp2cNxHuUMcDd-xHN-Kvv=A@mail.gmail.com>
 <ZzKmth5__xVUme1P@google.com>
 <CAE2F3rDrdPz1daR-QQYQ7WmeXo9NSvkfHPKwyJ=Ln=yRJd4sEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2F3rDrdPz1daR-QQYQ7WmeXo9NSvkfHPKwyJ=Ln=yRJd4sEw@mail.gmail.com>

On Mon, Nov 11, 2024 at 08:01:58PM -0800, Daniel Mentz wrote:
> On Mon, Nov 11, 2024 at 4:52 PM Pranjal Shrivastava <praan@google.com> wrote:
> >
> > On Mon, Nov 11, 2024 at 02:20:46PM -0800, Daniel Mentz wrote:
> > > On Thu, Nov 7, 2024 at 6:57 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > >
> > > > On Wed, Nov 06, 2024 at 04:16:19PM -0800, Daniel Mentz wrote:
> > > > > On Fri, Oct 18, 2024 at 11:00 AM Pranjal Shrivastava <praan@google.com> wrote:
> > > > > >
> > > > > > Introduce `struct arm_smmu_event` to represent event records.
> > > > > > Parse out relevant fields from raw event records for ease and
> > > > > > use the new `struct arm_smmu_event` instead.
> > > > > >
> > > > > > Signed-off-by: Daniel Mentz <danielmentz@google.com>
> > > > > > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > > > > > ---
> > > > >
> > > > > > +struct arm_smmu_event {
> > > > > > +       struct arm_smmu_device          *smmu;
> > > > > > +       u8                              id;
> > > > > > +       u8                              class;
> > > > > > +       u16                             stag;
> > > > > > +       u32                             sid;
> > > > > > +       u32                             ssid;
> > > > > > +       u64                             iova;
> > > > > > +       u64                             ipa;
> > > > > > +       u64                             raw[EVTQ_ENT_DWORDS];
> > > > >
> > > > > Consider removing the member named raw from struct arm_smmu_event.
> > > > > Compare this with struct arm_smmu_cmdq_ent and
> > > > > arm_smmu_cmdq_build_cmd() which keep the encoded and decoded versions
> > > > > separate.
> > > >
> > > > I had a similar implemntation in v3 [1] but it was decided [2]
> > > > to keep the "raw" event array within arm_smmu_event itself. Since
> > > > otherwise we'd have two variables, one pointing to the other when they
> > > > have the exact same scope and lifetime anyway.
> > >
> > > I understand that the concern in [2] was that "one [is] pointing to
> > > the other". At the time, I think you had a pointer in struct
> > > arm_smmu_event named raw, and the feedback was to embed the raw event
> > > data in the structure instead of having a pointer. What I'm proposing
> > > is to neither have a pointer nor embed it in the struct.
> > >
> > > >
> > > > Do we have a strong preference here?
> > >
> > > Not a strong preference, but I'd prefer to have the raw event and the
> > > decoded event separate.
> > >
> >
> > I see. So, do you suggest that we should have the raw print as it is and
> > then the pretty print separately like the following:
> > ---------------------------------------->8------------------------------------
> >
> >         while (!queue_remove_raw(q, raw_evt)) {
> >
> >                 arm_smmu_decode_event(raw_evt, &evt);
> >
> >                 if (arm_smmu_handle_evt(smmu, &evt)) {
> >                         dev_err(smmu->dev, "event 0x%02x received:\n", event->id);
> >                         for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> >                                 dev_err(smmu->dev, "\t0x%016llx\n", raw_evt[i]);
> >                         arm_smmu_dump_event(smmu, &evt, &rs);
> >                 }
> >
> >                 put_device(evt.dev);
> >                 cond_resched();
> >         }
> >
> > ---------------------------------------->8------------------------------------
> >
> > OR should we pass the raw event to the dump_event function which, I
> > believe, is a little duplicative:
> >
> > ---------------------------------->8-----------------------------
> >
> >         while (!queue_remove_raw(q, raw_evt)) {
> >                 arm_smmu_decode_event(raw_evt, &evt);
> >                 if (arm_smmu_handle_evt(smmu, &evt))
> >                         arm_smmu_dump_event(smmu, &evt, raw_evt, &rs);
> >                 put_device(evt.dev);
> >                 cond_resched();
> >         }
> >
> > ---------------------------------->8-----------------------------
> 
> Your second option would be my preference despite the fact that you
> have to pass in an extra parameter. It makes it clear that
> arm_smmu_dump_event prints both. I would make sure that the order of
> &evt and raw_evt in the argument list matches the order in which
> arm_smmu_dump_event is printing them.
> 

Ack. I'll post a v5 soon and accommodate this with it! Thanks!

> >
> > > >
> > > > >
> > > > > > +       bool                            stall;
> > > > > > +       bool                            ssid_valid;
> > > > > > +       bool                            privileged;
> > > > > > +       bool                            instruction;
> > > > > > +       bool                            s2;
> > > > > > +       bool                            read;
> > > > > > +};
> > > >
> > > > Thanks,
> > > > Praan
> > > >
> > > > [1] https://lore.kernel.org/all/20240928005143.2378938-2-praan@google.com/
> > > > [2] https://lore.kernel.org/all/5eda3ba6-c35a-432b-be87-48bd8a0a3bf1@arm.com/
