Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5307B
	for <iommu@lists.linux.dev>; Fri, 14 Oct 2022 06:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665730385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bg6+iPwRJNBmQ/gourxOyjQutuo/8BXNZAqpSt/I6YI=;
	b=LPRJ9IZRDW/X5GuV3gUz6215j5S0iTjz4e9rvWycViPqX/NIAdavSPitYtONBX9iS40gMT
	/AjalUU2SSyTf8f7wzWs0/uI9PuytldQAoTHfsr9BirXtq6LLStCrRTmTStyL+7cZuiFpL
	xLppbO7AIEjcUv7Dk4Ikvcwn3PsRZZc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-O6R_tNTDOtWY_sVy-9er2A-1; Fri, 14 Oct 2022 02:53:02 -0400
X-MC-Unique: O6R_tNTDOtWY_sVy-9er2A-1
Received: by mail-oi1-f197.google.com with SMTP id l8-20020aca1908000000b003545ede8b31so1775139oii.7
        for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 23:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bg6+iPwRJNBmQ/gourxOyjQutuo/8BXNZAqpSt/I6YI=;
        b=AgNJO3tDRnfaFA2I1EZPHjGfhIV8FcgWbEILjdK9OtG8eyNMV1dl6h6DFxUusx7Fcj
         NSsq8eL8OUT7Kulwn8TwCFC3a4KUwCB1o32Fcc1orM9NLwyeWY8RW5zo1g5ijJjiLKBY
         +4L2rLEFY66HE1XdhT319vXBugGtwAdGZHPK54VnXfgk+2VGxDotVEKTJfIBTGEFak6Y
         XMiNp3NL+bfOxgf5IUDSWY4GvkW5rT5LhgVi+nuwrw/hwo9vWHVMnD7RBe/Fr+WwDHR4
         596nC6KQicrrUJ7eheSf/SUy/Ezt0zwEvjTCBjhSX93wshCIlpOM1iAm1L36mrb0qh/R
         TapQ==
X-Gm-Message-State: ACrzQf3yZXXqqnnmiQlpTnmjXvOK6j21q4NbZiDg224xL1Xx0lCHGaMg
	JWCWGZs5sZWWjg+t9ugnBf8EASyJHM+yXgsM9NrT6OO5Tw9qWQU/dOUgxznRTMgcC76UCAJSOI6
	SZy90OENawYra79w=
X-Received: by 2002:a05:6870:c182:b0:12a:e54e:c6e8 with SMTP id h2-20020a056870c18200b0012ae54ec6e8mr7541525oad.207.1665730381482;
        Thu, 13 Oct 2022 23:53:01 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM77dda9I2lRb+09JsGoPMiyD9sl6LXVXCKo7W/YqMF5KMfsjOnVEgEE3JkvMt5pYnkQe0UoNg==
X-Received: by 2002:a05:6870:c182:b0:12a:e54e:c6e8 with SMTP id h2-20020a056870c18200b0012ae54ec6e8mr7541519oad.207.1665730381175;
        Thu, 13 Oct 2022 23:53:01 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id e18-20020a056808149200b003549397fde4sm738630oiw.54.2022.10.13.23.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 23:53:00 -0700 (PDT)
Date: Thu, 13 Oct 2022 23:52:59 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>
Subject: Re: [RFC PATCH] iommu/vt-d: Add sanity check to
 iommu_sva_bind_device()
Message-ID: <20221014065259.5koqcoxiuegg6kzj@cantor>
References: <20221013153355.2365865-1-jsnitsel@redhat.com>
 <89029bfb-bdf6-43e3-b24c-09c266277f0e@linux.intel.com>
 <20221014021043.4rpzufoleeg7z5gx@cantor>
 <ea7ea775-5b87-82d6-c30a-8e60f1462476@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ea7ea775-5b87-82d6-c30a-8e60f1462476@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 14, 2022 at 10:22:21AM +0800, Baolu Lu wrote:
> On 2022/10/14 10:10, Jerry Snitselaar wrote:
> > On Fri, Oct 14, 2022 at 09:52:44AM +0800, Baolu Lu wrote:
> > > On 2022/10/13 23:33, Jerry Snitselaar wrote:
> > > > iommu_sva_bind_device() should only be called if
> > > > iommu_dev_enable_feature() succeeded. There has been one case already
> > > > where that hasn't been the case, which resulted in a null pointer
> > > > deref in dev_iommu_ops(). To avoid that happening in the future if
> > > > another driver makes that mistake, sanity check dev->iommu and
> > > > dev->iommu->iommu_dev prior to calling dev_iommu_ops().
> > > > 
> > > > Cc: Joerg Roedel<joro@8bytes.org>
> > > > Cc: Will Deacon<will@kernel.org>
> > > > Cc: Robin Murphy<robin.murphy@arm.com>
> > > > Cc: Lu Baolu<baolu.lu@linux.intel.com>
> > > > Signed-off-by: Jerry Snitselaar<jsnitsel@redhat.com>
> > > > ---
> > > > drivers/iommu/iommu.c | 10 +++++++++-
> > > >    1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index 4893c2429ca5..20ec75667529 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -2746,7 +2746,15 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> > > >    {
> > > >    	struct iommu_group *group;
> > > >    	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> > > > -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> > > > +	const struct iommu_ops *ops;
> > > > +
> > > > +	if (!dev->iommu || !dev->iommu->iommu_dev) {
> > > > +		dev_warn(dev, "%s called without checking succes of iommu_dev_enable_feature?\n",
> > > > +			__func__);
> > > > +		return ERR_PTR(-ENODEV);
> > > > +	}
> > > If that's the case, dev_iommu_ops() will warn a NULL pointer reference.
> > > This kind of error will be discovered at the first place.
> > > 
> > > Best regards,
> > > baolu
> > > 
> > It will warn this by crashing the system (example from back when idxd had the problem):
> > 
> >      [   21.423729] BUG: kernel NULL pointer dereference, address: 0000000000000038
> >      [   21.445108] #PF: supervisor read access in kernel mode
> >      [   21.450912] #PF: error_code(0x0000) - not-present page
> >      [   21.456706] PGD 0
> >      [   21.459047] Oops: 0000 [#1] PREEMPT SMP NOPTI
> >      [   21.464004] CPU: 0 PID: 1420 Comm: kworker/0:3 Not tainted 5.19.0-0.rc3.27.eln120.x86_64 #1
> >      [   21.464011] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.SYS.0067.D12.2110190954 10/19/2021
> >      [   21.464015] Workqueue: events work_for_cpu_fn
> >      [   21.464030] RIP: 0010:iommu_sva_bind_device+0x1d/0xe0
> >      [   21.464046] Code: c3 cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 49 89 d6 41 55 41 54 55 53 48 83 ec 08 48 8b 87 d8 02 00 00 <48> 8b 40 38 48 8b 50 10 48 83 7a 70 00 48 89 14 24 0f 84 91 00 00
> >      [   21.464050] RSP: 0018:ff7245d9096b7db8 EFLAGS: 00010296
> >      [   21.464054] RAX: 0000000000000000 RBX: ff1eadeec8a51000 RCX: 0000000000000000
> >      [   21.464058] RDX: ff7245d9096b7e24 RSI: 0000000000000000 RDI: ff1eadeec8a510d0
> >      [   21.464060] RBP: ff1eadeec8a51000 R08: ffffffffb1a12300 R09: ff1eadffbfce25b4
> >      [   21.464062] R10: ffffffffffffffff R11: 0000000000000038 R12: ffffffffc09f8000
> >      [   21.464065] R13: ff1eadeec8a510d0 R14: ff7245d9096b7e24 R15: ff1eaddf54429000
> >      [   21.464067] FS:  0000000000000000(0000) GS:ff1eadee7f600000(0000) knlGS:0000000000000000
> >      [   21.464070] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >      [   21.464072] CR2: 0000000000000038 CR3: 00000008c0e10006 CR4: 0000000000771ef0
> >      [   21.464074] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >      [   21.464076] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> >      [   21.464078] PKRU: 55555554
> >      [   21.464079] Call Trace:
> >      [   21.464083]  <TASK>
> >      [   21.464092]  idxd_pci_probe+0x259/0x1070 [idxd]
> >      [   21.464121]  local_pci_probe+0x3e/0x80
> >      [   21.464132]  work_for_cpu_fn+0x13/0x20
> >      [   21.464136]  process_one_work+0x1c4/0x380
> >      [   21.464143]  worker_thread+0x1ab/0x380
> >      [   21.464147]  ? _raw_spin_lock_irqsave+0x23/0x50
> >      [   21.464158]  ? process_one_work+0x380/0x380
> >      [   21.464161]  kthread+0xe6/0x110
> >      [   21.464168]  ? kthread_complete_and_exit+0x20/0x20
> >      [   21.464172]  ret_from_fork+0x1f/0x30
> > 
> > 
> > It was doing that to SPR systems that didn't boot with
> > intel_iommu=on. They had to either enable the iommu, or blacklist the
> > idxd driver until the idxd driver had a fix. The idea here is to
> > avoid taking the system down, and just have the driver get an error back.
> 
> If IOMMU is disabled, the iommu_dev_enable_feat(SVA) will return an
> error, the idxd driver should not call the sva_bind() interfaces
> anymore. If the driver doesn't do like this, why not fixing it in the
> driver itself?
> 
> Best regards,
> baolu

The idxd case was found, and fixed by me back in June. I just was
showing the stack trace to show that it crashes the system, not just
puts out a warning.

Why would this stop someone fixing the problem in a driver that is
calling sva_bind() interface incorrectly?

Nothing else in the system cares that some driver forgot to call
iommu_dev_enable_feat(), or forgot to check the return value. Nothing
else would be impacted by it, except that the system is being allowed
to crash. If the idea is to get noticed more quickly, couldn't a
WARN_ON() + returning an error solve that without resorting to
crashing the system?

Regards,
Jerry

