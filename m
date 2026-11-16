Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794861103;
	b=ptv/Tbb63tYmdu3qrnfNM2v41BXwr+X7Ndai87h2u6/4kDeWn4NeXNp+pIwJlwjLJR8h
	 1Ni84HmjZ+XmBkQdzya0LYLMn1LmXNbmDrAIxIa0YyvEBuQ3bXqtV+fgpj037CkjRe64Y
	 2sgrdemspBlV45ed52/FnAu+3Siy/535zwsZITR0b0Za03PUMKZsJOwZINMCMuBKFPX81
	 9XtRFVqITrURClJEPO3jXPnKvZ245coQ2cmylZHvntSO7EBQgD24OgMNNagDS57uJJyU1
	 GOWnDIoGAJTw7gi/N6uGeaG2cEkEvsPIGmzdOIllbQSF3jiVK0mimAmqNQf62FyX8KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794861103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eRRcFDo3SjeXTCoZblTh2PIPZiyfkDH6eOzhBNd40gs=;
	b=FVgyqF20LB4IetoM7gygu8yv/iCxAU9ciSut8HS7RbtaCAJ9Rbds4ahVFjIyHl7+iwoq
	 L3r0dBVmhRMnU4JjmtMcaomkdYWJUIzd1pQ3ECROCTPC8tlDXlQSA4eCJR07yPzie/gDq
	 LACos2k5D2ScIFXvH0RnFZpVD6aJzrH+ND0owBjY6GeUYKXM5l7MKbOaGoiARPVtpJhZs
	 sOf5ZDHq4AXGog4Q8ws12Lez5jMo2hc5FMyZRUXoWhPU6xJxfoONLM7hg6mZSCBDzmNal
	 rjyGDikmIPwOPc1tYTzr0ZfkI/UTSGz1gssu+mC/x2vmHd94UhSCqL6ZtaOkeUrkyWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9c3STff;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F0606A32C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475F0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y9c3STff
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1ae7fc5681dso1412c88.1
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794861102; x=1795465902; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eRRcFDo3SjeXTCoZblTh2PIPZiyfkDH6eOzhBNd40gs=;
        b=Y9c3STff5ta0iyUWq9yrgHdzonyixo6fNT6Y9W2TsvXF+cRAClWmPLALFhaz0dkwpL
         WoE2WoDgUKSnpoJIqz1EtdYhaojtcLWh19ig/HA76yPT2QGGpHT6VaxFA/En+jwCs8lj
         PJBN5ZUGTj/BoVK4PsNg3xRJWNHGlaLp6OaNV+WA5QRxqt+JNfFpALWXkFy0FTGGqU/J
         loj6lNgzEW+cOLlT7Jqc+550MWHDEyNFJvnmp8QehDYyi8MrvwciHD8+c6e/9/HYxiWt
         ZSLUUa/wnVDJmDnXofmaCeL7Siq4qDB6X7OxOyAqU40YZF+AGyZyadfV+jg9gR/T/Idr
         qgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794861102; x=1795465902;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRRcFDo3SjeXTCoZblTh2PIPZiyfkDH6eOzhBNd40gs=;
        b=dCOCS+Y0bHD/rdqtgjsdlYGpodMM1qCYn0MbECVrMHz4efbWanTxk36kF4E41ol+tn
         bUevEVOaG/4b3Tue01UqOtvF14L2rS04bG/vcyomUmnN+AcYmZsg98+WZtcQYyU3ECrP
         3zGk0l+clNMtmb7gEmxy4/o0Zs6x4EXbipqVdeRXUO22auQUwVcWiZ40JWFVrzc+ug9g
         yCznWRql5C+KkllyFxtCehoF2AZtc/21J7mopcIruN1c7O+6JlUQNrIxuqi33Xzh/3+6
         V2clrSkbpbqWmGf6etkTXtLPtRZwpPzd4M8rCP1MVc0vg64eiU5tS1c2nM9Th1FLkATQ
         8Nuw==
X-Forwarded-Encrypted: i=1; AL+hErFHg7mrLvN0Hmn8Eoo07t8VhNwV1MfYjXQNY6CkB2iaOtTaat+sKniNS8uLsz10nm4ai+AZmQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8TICHli9Mj82dUhEK2TSpeB6RNLypsbbQaX/++LnNRuyoWcHhp
	GS5EomiZxIXtpNU/srS+Dry6jPFT3Q2OhopizkVhN3GDE1ZWkkce0TfSYxE3Tt3ZJ5GfBZl2RLC
	UR1vA9Q==
X-Gm-Gg: AYBFou2+BqZMag3NjMHUcRoNyJ+YDFBu1T01sqCxWR7pjQl0g8iEzIHJNHZdOaZMFze
	LM1LC3+Uh3SZaEvfRWQFI17BRvlD4HbN7XJkiV0z013NOR6Sd/faNEFIsH/fbkQOdkNOepelALz
	gPFd2mHzc3ooacQgHa/Zy3PmNLEvKHoegcPoSjEg3hk7xCTJYAJ3SYG6M74ZvOotZidU/r4h2PO
	3yJ9mgfi8g/g38VZjuRdUwmIW7y8646Fi4qOpmjFikF9U7IEF68U/5cuLTJazTkrWQEMFDjg/kl
	8+g7bOSGUggth//DeguwqQ9UMIJZHq1TvYqikVsImkupwZkgS3U+J9YlNd04OAGRztC0LcN8HZw
	Rznf1xt3v+D0wv409OylQ+rFWzpBa4XOurz+l31+iy/yxM8zfacYKyfz5DA+ZsWKjpQF4i8EzzS
	Zvu6rMQdzE/n4BqPAxsaP6YoY8n9esqZVIXrnGxTVHi+r7XO/ZsZ67UZqXXBgKiy7HgKj9TCYcl
	HTgnRU1EXJeFDT1TzKoP2KBG2zda3qjiqhIc1wmiriBeyW7GtYSf1L4oTQHo0NFbVebLmMA3MD8
	HdpyrxMLROCTgofH31FYDbZni9nIYPD31J6EnNY9jHEw1vcFaAdSWabtMuJHb+ZiQJA=
X-Received: by 2002:a05:7023:e41:20b0:162:1b69:fe06 with SMTP id a92af1059eb24-1b53b1c3099mr7831c88.14.1794861101375;
        Mon, 16 Nov 2026 12:31:41 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955e0d966sm37451776eec.15.2026.11.16.12.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:31:40 -0800 (PST)
Date: Mon, 16 Nov 2026 20:31:35 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: Honor iommufd uapi for zero entry_num args
Message-ID: <avtoJ88ELacDrquz@google.com>
References: <20261112151039.2083705-1-praan@google.com>
 <avdO5cBwc/2ysstZ@nvidia.com>
 <avromFJ6opeGEcT_@google.com>
 <20261116130832.GC1850935@nvidia.com>
 <avtltxy9sp6cYiEP@google.com>
 <20261116202354.GE2245175@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116202354.GE2245175@nvidia.com>

On Mon, Nov 16, 2026 at 04:23:54PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 16, 2026 at 08:21:11PM +0000, Pranjal Shrivastava wrote:
> > On Mon, Nov 16, 2026 at 09:08:32AM -0400, Jason Gunthorpe wrote:
> > > On Mon, Nov 16, 2026 at 11:27:20AM +0000, Pranjal Shrivastava wrote:
> > > > On Fri, Nov 13, 2026 at 09:54:45AM -0800, Nicolin Chen wrote:
> > > > > On Thu, Nov 12, 2026 at 03:10:39PM +0000, Pranjal Shrivastava wrote:
> > > > > > @@ -556,7 +556,8 @@ static inline int __iommu_copy_struct_from_user_array(
> > > > > >   * @data_type: The data type of the @kdst. Must match with @user_array->type
> > > > > >   *
> > > > > >   * Copy the entire user array. kdst must have room for kdst_entry_size *
> > > > > > - * user_array->entry_num bytes. Return 0 for success, otherwise -error.
> > > > > > + * user_array->entry_num bytes. An empty array copies nothing, though its
> > > > > > + * @data_type is still validated. Return 0 for success, otherwise -error.
> > > > > >   */
> > > > > >  static inline int
> > > > > >  iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > > > > > @@ -569,7 +570,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > > > > >  	if (user_array->type != data_type)
> > > > > >  		return -EINVAL;
> > > > > >  	if (!user_array->entry_num)
> > > > > > -		return -EINVAL;
> > > > > > +		return 0;
> > > > > 
> > > > > TBH, this doesn't seem very necessary..
> > > > > 
> > > > > Though I don't have a problem so long as Jason is okay with it..
> > > > > 
> > > > 
> > > > I know it looks unnecessary in-tree, but zero-length is the documented
> > > > way to check if a @data_type is supported.
> > > 
> > > Is it? I though it was put in 0 length and look for EOPNOTSUPP,
> > > success is not expected.
> > > 
> > 
> > Reading the uAPI comment [1] gives me that understanding:
> > 
> >  /*
> >   * An empty invalidation request array by setting @entry_num==0 is
> >   * allowed, and @entry_len and @data_uptr would be ignored in this case.
> >   * This can be used to check if the given @data_type is supported or
> >   * not by kernel.
> >   */
> > 
> > Hence, for a supported data_type I expect success..
> 
> No, you can't create most of these viommu types without giving actual
> data.
> 
> The comment is unclear, it should be looking for -EOPNOTSUPP.
> 
> > Also, the selftests check exactly that [2]. An unsupported data_type gets
> > -EINVAL from the drivers today, not -EOPNOTSUPP (happy to switch if you
> > prefer).
> 
> EINVAL should only mean that the data inside the struct is
> invalid, but everything else is understood. If the enum itself is not
> known that has to be EOPNOTSUPP
> 

I see! I'll respin the patch to return -EOPNOTSUPP for an unknown
data_type (copy helpers, intel/selftest invalidation ops and the
selftests) and fix the uAPI comment to say the probe should look for
-EOPNOTSUPP. Does that sound fine?

Thanks,
Praan
