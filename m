Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7290352937
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932859; cv=pass; b=PuiAll9m034UbyMp9mx0V67mI8+/gpXSLAz7ytpXAqScJaY1yECHNxnOwRanMp+Jek0vrgOje2TDiDKTPAZ2yNjllsernbWU2RJhpW36RBQNWktznlSvtHHKWB/RFeg+TmGtEiPK61ggAp549ISHxSk6aFpCBUKTQVMCRoxGIfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932859; c=relaxed/simple;
	bh=0fJdWXOM6Dtq/R+Hnr7XJV7UpyfTRGhvQ3tnDwo+haY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSbvTDIrP/hHaPs/cpXdzwuxEa9R0Vb3Zmly3E3wT4JpqeL4RDKiyVywH51INRIQN33I97ftpIXtF0SW9p8GBUM+4qhzgnD2FVJaArGVtqWt4zCfQnWgcVhiAPOjNCEiGHWLIJRn6wfNJWYwRafx3XZyi/EaFKt0bVs70M9X6FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJB5F9up; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJB5F9up"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-501511aa012so23241cf.0
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 10:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932857; cv=none;
        d=google.com; s=arc-20240605;
        b=RLgJLhyeQK0A38LWWcrCQw+MDqYKMhk9npZJyUvTt2qw5T9NORjG3fJ+EmWbrgeC5E
         kYna6fzMuze3cT1SzG8PjdyuZTvADyLrf04ivO2El2pgSytoVrxpVEqVnayDRBmRSD2t
         vQrk1DDhjC0FTQ1MnfcZnbQpeE5lrd1oCbfjEPGUV19Rl7JlqVy2TLA5e/VxHBxqpyyH
         qlbA5MKMhi8tEdblWXp+8TlOWJ1fqCSh2EBhUxQkx72+vQuqx7kEjmtBMev/QMYAra63
         2sAnEd5gPIHHYQhz0p3q91Z2UFPYTbZx7xZoZw/EmzYwUqj5V+D4ubqMSKNLI65Xc8vR
         YAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jWllGn/666dDHTAPleqc1eT9U1mCL6EfE7UtY9KuD70=;
        fh=rH0xph/NkTeI0sSrbbuTkWH6BJ98AKzZsdUA0ld4KXk=;
        b=QI9OCMAYjtbKbUy7BW6Eg20o2KSJWUEm1lQSOFRnzWk6UgsHs2FYlm350Mnnx3tD/d
         U3FxWAAn3PtcxMoro8QcDLnvClhrTuzOtngfZW15Zqrsk/cSHbXCUZzaPfhajNKoc+zc
         MkIkm6y1mbMdWYAbZhP7AabOgI8YBdqJtfz3PhSL4TY3/DY15nfS7CeXLSxDXafOnTR/
         H5uiggUOx/6Ts6zcEL4uc6qI6mcOEFHvL2QlK+V37KuBrsd/V2Nr/yFYnP0TBWD1ybXq
         Kk+UwXNd3pWte2Xgdor47vaWe1Cn8RaKVjyArpLX9TOiryDJaaV6qZkEX/S02urU2us8
         ao4w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768932857; x=1769537657; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWllGn/666dDHTAPleqc1eT9U1mCL6EfE7UtY9KuD70=;
        b=uJB5F9upomoI9AnJrUz5X5MFtTktG2BPSP1sw7fyxtp+FGQDMnv0qNNQuu7dIlqQaP
         UCfpjlAVMPffIw7JVPiA83eM3r84YVAnLkkeJ3nSidfMlDpc1r9P4K6Dl4ownJRnhirb
         qyCpaJ2EZ0NyScPCc6JC68qLTnFZsJGSg7ishqzC4+60vUbWm0gJwg/pHA4u3Yz3G8IV
         w9rbs24DmdTa8ShxkCg3MwGBngS/my1XfNEd4nFzXrWCHXxIfr7XiyIdsXldFVqDpjOY
         2KHCttWjRCGLOM4mfyzoZEEJolp9IOe5NIX1vt3OY5o+sM5AZzUP9wn30tr4ptrW2so9
         4xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932857; x=1769537657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWllGn/666dDHTAPleqc1eT9U1mCL6EfE7UtY9KuD70=;
        b=bGmmtsgpH0nr/ertJjoLzgHh2j9PI+r0aivfTsys3b5xMY9fXLrbS7qf+/vos8zbfm
         uceG5No6TN/2mSWTJqnib53u8hbAACCHdK2awHqU9974hB13zTE4lJp6xEW78PbRiO3z
         9hoS/LCRJnBy1ICuuXAut/5hXd/QwVEaB8fnKZvTdMwV174PgX0rla9jBrEWdTKqJRnP
         KKAl2Q1JcybOdZ5IXmEGxpiM5+585KA5nHBqbNVnNnvGXo+FUqWmOUdaWL5iETm0Gpmt
         dIRsJfnZmUtqRJaTHoe2knhFNJkTRma1g24G7q1fxiXw+OsD8JEdLvMjdPvh6CX0CTPk
         icsA==
X-Forwarded-Encrypted: i=1; AJvYcCUHcLLkUW2A3G+RYd585NXN4olKxBiTZ0KgHrw3cDNfkCoa9T10+adTD0kpbid9PVWpYPVy/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzK5PxeFZonPYWaZlqjyPqDfchW3WB+IVLeqwv08Goitb8QUHh
	1c0w6gY2gqofhmjAJMCaW2cxrQNPCX4t/hjgCDjyFiM9zRJ/tEQrU41LUFeSAM5SUWeFznXtGk1
	NV6pA+6OWuhiKsQEvtr8dQMG/IK43OiqvXNmOAnaT
X-Gm-Gg: AY/fxX6Qg69dMGUqD2QV9sMf/UPD6z12zDOz7vV/pesCCdFNJOhYQNvpNXQaObHkVKl
	zuWvkBecUMnaectbl/JSP1REWktxdjKPLchB5CUQLnlcGFnCGruQTA4RGrJXlGnPq0+z8Zn3UjP
	JfQEj5kE4WLIDC1t2PlBHNb5Go0mzKZwdUzqclbTGtzBcQcigvW63FEtuFysq7sdxAiaTk0pI7n
	6ybaLEy4525Nl6Qp3R87055AwlaGO2bEeBDm4MSUN3HJUnAAtrvHI8Hr5YVKttoRyme1n02+IWJ
	FXIdFaZm58UlMRK/QPKeWnNr
X-Received: by 2002:ac8:7d48:0:b0:4ff:c0e7:be9c with SMTP id
 d75a77b69052e-502e0b3f027mr743741cf.0.1768932854818; Tue, 20 Jan 2026
 10:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-2-baolu.lu@linux.intel.com> <aW-JpXkqEpGTL7eq@google.com>
In-Reply-To: <aW-JpXkqEpGTL7eq@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 20 Jan 2026 10:14:03 -0800
X-Gm-Features: AZwV_Qh73NSmgBcoZOcCsvq4LrezVr5tEsHMJJlQazWx8qAbBKeLPeh_Kni5GXg
Message-ID: <CAAywjhT=QwKyh2XYJ82MQ-1Ot8Vv+8t69p8JdVTKhA=LX+c_jA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
To: Dmytro Maluka <dmaluka@chromium.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Aashish Sharma <aashish@aashishsharma.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 5:56=E2=80=AFAM Dmytro Maluka <dmaluka@chromium.org=
> wrote:
>
> On Tue, Jan 20, 2026 at 02:18:12PM +0800, Lu Baolu wrote:
> > The Intel VT-d Scalable Mode PASID table entry consists of 512 bits (64
> > bytes). When tearing down an entry, the current implementation zeros th=
e
> > entire 64-byte structure immediately using multiple 64-bit writes.
> >
> > Since the IOMMU hardware may fetch these 64 bytes using multiple
> > internal transactions (e.g., four 128-bit bursts), updating or zeroing
> > the entire entry while it is active (P=3D1) risks a "torn" read. If a
> > hardware fetch occurs simultaneously with the CPU zeroing the entry, th=
e
> > hardware could observe an inconsistent state, leading to unpredictable
> > behavior or spurious faults.
> >
> > Follow the "Guidance to Software for Invalidations" in the VT-d spec
> > (Section 6.5.3.3) by implementing the recommended ownership handshake:
> >
> > 1. Clear only the 'Present' (P) bit of the PASID entry.
> > 2. Use a dma_wmb() to ensure the cleared bit is visible to hardware
> >    before proceeding.
> > 3. Execute the required invalidation sequence (PASID cache, IOTLB, and
> >    Device-TLB flush) to ensure the hardware has released all cached
> >    references.
> > 4. Only after the flushes are complete, zero out the remaining fields
> >    of the PASID entry.
> >
> > Also, add a dma_wmb() in pasid_set_present() to ensure that all other
> > fields of the PASID entry are visible to the hardware before the Presen=
t
> > bit is set.
> >
> > Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>
> Reviewed-by: Dmytro Maluka <dmaluka@chromium.org>
>
> > ---
> >  drivers/iommu/intel/pasid.h | 14 ++++++++++++++
> >  drivers/iommu/intel/pasid.c |  6 +++++-
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> > index b4c85242dc79..0b303bd0b0c1 100644
> > --- a/drivers/iommu/intel/pasid.h
> > +++ b/drivers/iommu/intel/pasid.h
> > @@ -234,9 +234,23 @@ static inline void pasid_set_wpe(struct pasid_entr=
y *pe)
> >   */
> >  static inline void pasid_set_present(struct pasid_entry *pe)
> >  {
> > +     dma_wmb();
> >       pasid_set_bits(&pe->val[0], 1 << 0, 1);
> >  }
> >
> > +/*
> > + * Clear the Present (P) bit (bit 0) of a scalable-mode PASID table en=
try.
> > + * This initiates the transition of the entry's ownership from hardwar=
e
> > + * to software. The caller is responsible for fulfilling the invalidat=
ion
> > + * handshake recommended by the VT-d spec, Section 6.5.3.3 (Guidance t=
o
> > + * Software for Invalidations).
> > + */
> > +static inline void pasid_clear_present(struct pasid_entry *pe)
> > +{
> > +     pasid_set_bits(&pe->val[0], 1 << 0, 0);
> > +     dma_wmb();
> > +}
> > +
> >  /*
> >   * Setup Page Walk Snoop bit (Bit 87) of a scalable mode PASID
> >   * entry.
> > diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> > index 3e2255057079..eb069aefa4fa 100644
> > --- a/drivers/iommu/intel/pasid.c
> > +++ b/drivers/iommu/intel/pasid.c
> > @@ -272,7 +272,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu=
 *iommu, struct device *dev,
> >
> >       did =3D pasid_get_domain_id(pte);
> >       pgtt =3D pasid_pte_get_pgtt(pte);
> > -     intel_pasid_clear_entry(dev, pasid, fault_ignore);
> > +     pasid_clear_present(pte);
> >       spin_unlock(&iommu->lock);
> >
> >       if (!ecap_coherent(iommu->ecap))
> > @@ -286,6 +286,10 @@ void intel_pasid_tear_down_entry(struct intel_iomm=
u *iommu, struct device *dev,
> >               iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FL=
USH);
> >
> >       devtlb_invalidation_with_pasid(iommu, dev, pasid);
> > +     intel_pasid_clear_entry(dev, pasid, fault_ignore);
> > +     if (!ecap_coherent(iommu->ecap))
> > +             clflush_cache_range(pte, sizeof(*pte));
> > +
> >       if (!fault_ignore)
> >               intel_iommu_drain_pasid_prq(dev, pasid);
> >  }
> > --
> > 2.43.0

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
