Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABF22E090E
	for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758717956; cv=none; b=FUnwvWgBuOeNRc/TxcnLjCRGmI/fNJnVPguDkBiih2LvJkVWGmQ4gJK/w4brtXP7vLVFr+/zgJIc58IyvYNgXqPHG0Q7HVWMur1obndBOTU9ZHQ7isIhJ/FavLE8or/dk66hqyKZuqiygLES3KcaRU2bQbwfzMXLrYtJTV9EcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758717956; c=relaxed/simple;
	bh=t1PT40Xa4Dq+KyxteCViW5Qsz3L/IkWqFDFMBeyzK9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjGdUvFpn+IdzXUcZtGfGSjiIcaOmJ9xD7XOYTti/GrYlisRRS3kHkj7kSN5aftl+9zKZyalnFmRTKnw8/ZG0Oq9C8+jvNooX12ziMBKjcRZXOqDG+p+3sMEfUX/o1IRQeu+/dCEw74XioShoRtHYgafKZCShUOM5MQCMaCNJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Bqs+4tti; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Bqs+4tti"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b7a967a990so75415611cf.2
        for <iommu@lists.linux.dev>; Wed, 24 Sep 2025 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758717953; x=1759322753; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6bfo4bnSZkmykbuJKbewat5BPyEoGg+coLh0zjefBOo=;
        b=Bqs+4tti+8sRjLAPKZpg3LJj4DhzjRTH4x/KtxR9CsjTGrAW4FegJv4COes+cf0fa5
         dgSKKYZw4YsziCE+U7M6HpZYvQstiJGyZmPqT9g5w8mpkziykmKrKEt6NjU3jTy8wLVV
         +9IzJu5JCneWyufiZYA6Ci0mVUsBswRmINPDrY6BGY3Zdczw27bD/ecXkHiUaKvD9nVp
         hy1Q/L+Gnvxfe8E+1kikdEm1qJI4IpW7d9JQTVfgbGFPm7m7IyG+M6japnClGRDHeY3y
         H3oO8q/lFTHtmxOuFaoKHQ6YbPblT06MHZIIvN9upJv3822PUv8rJr0nwoPOCDuVdnPo
         9EIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758717953; x=1759322753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6bfo4bnSZkmykbuJKbewat5BPyEoGg+coLh0zjefBOo=;
        b=Vi3YAgCfr3JN8yxRKh6Bk8SB61SB3DxsOV9bBKNhh8ABAlvVBwO24Z2H0E80flmuL1
         gtnyLPnftNhX+cgq6v0P+XGBUrDFOx6dzGppLPWZn15o+paD/o9Kjjf1PThfeyVIqe8h
         ziwD9b+JxhZPtNmjEy2r4kRbhuWGnL8p/+tUam9zjvZvmBjsFEyARHhaBf2pmj4ykw/q
         KXE0WZxtOGcXnSOIlrCpK9A/fxpcDcI3wKpcEUOLvTpJuBzl2SdktvjgubcfGs+HUOob
         Z+80dC+rmxolqWYk9hipTbgn0QKZHxbHyDGxl5RJtE/IF0LtDVg+/of0cnLwqx+qdh5B
         4UVA==
X-Forwarded-Encrypted: i=1; AJvYcCXPyt6SnNRuTLqiuHVxuRYtLusafOQCGCrYkvU1NpquWdFLpsfbS1rZk0oJzu5WOCJfbFAEbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYcdxDXYmFAxpYfR3Fc6S2+i6A1LYlnVgGuhvz6VRJI2EHntb9
	qUeE8pYGnV8JJ03i2f3c/mUfOZJoZq5BM5XAfVFHAcx/jyfDmsaR89NYpEATPBaPy+0=
X-Gm-Gg: ASbGnctuMURWAJ7btdlVjNYgVjY57Yy9NHFwzTgrPGcYpKSBvT4HV4EhTvPHwmoBi7y
	uPx38T75T4EqdNaUzYFrfxpYM47+O4GZlxhjMnY0Lit7ukYCHG+s9HKPEoCZ+nSdHi+BDm9lnLH
	Tm9E1nqHuOUoWBOkqzyvah2yFkO0IGY7cFqQarjvYhhxIbRQ2CeUl5ysgSGzktoSpx69S9F3LHq
	GrYx3ueiFRZH5XeVpmA8PR3ytqkEcArJCfTG8ovpW1zVVTbYhplfwqQi40rbwFBoi4sIJHVmqBh
	Lu9G/Q2SkD95mLQdPBvHKJkG9kw2nzEGT4a4mFCoURB4aG3YFp8B76rjYo0TdPjw5Yy+yukN
X-Google-Smtp-Source: AGHT+IGCrzwAZBuNZMLUevUeVR85F+Mp4gKHOXBdC/wrWMdBzNXtEI8v7/3alXA68gxLWQyrIaqIZQ==
X-Received: by 2002:a05:622a:11c9:b0:4b5:f75c:156c with SMTP id d75a77b69052e-4d36a18b80amr70770681cf.28.1758717952649;
        Wed, 24 Sep 2025 05:45:52 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4d0c9a15c4fsm36822761cf.2.2025.09.24.05.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 05:45:51 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v1OsY-0000000B7dC-30kP;
	Wed, 24 Sep 2025 09:45:50 -0300
Date: Wed, 24 Sep 2025 09:45:50 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alessandro Zanni <alessandrozanni.dev@gmail.com>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, kevin.tian@intel.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/iommu: prevent use of uninitialized variable
Message-ID: <20250924124550.GH2547959@ziepe.ca>
References: <20250923150108.34309-1-alessandro.zanni87@gmail.com>
 <20250923172822.GD2547959@ziepe.ca>
 <y7xzjzbquglgrmbufbbqksvshuaofod6alql6gqfbzhq6s33pk@dw4ma6kctr5s>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <y7xzjzbquglgrmbufbbqksvshuaofod6alql6gqfbzhq6s33pk@dw4ma6kctr5s>

On Tue, Sep 23, 2025 at 11:38:13PM +0200, Alessandro Zanni wrote:
> On Tue, Sep 23, 2025 at 02:28:22PM -0300, Jason Gunthorpe wrote:
> > On Tue, Sep 23, 2025 at 05:01:06PM +0200, Alessandro Zanni wrote:
> > > Fix to avoid the usage of the `res` variable uninitialized in the
> > > following macro expansions.
> > > 
> > > It solves the following warning:
> > > In function ‘iommufd_viommu_vdevice_alloc’,
> > >   inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> > > iommufd.c:2889:1:
> > > ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> > > [-Wmaybe-uninitialized]
> > >   760 |   if (!(__exp _t __seen)) { \
> > >       |      ^
> > > ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
> > >   513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
> > >       |   ^~~~~~~~
> > > iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
> > >  1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> > > nvevents))
> > >       |   ^~~~~~~~~
> > > iommufd.c:2924:17: note: in expansion of macro
> > > ‘test_cmd_trigger_vevents’
> > >  2924 |   test_cmd_trigger_vevents(dev_id, 3);
> > >       |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > > 
> > > The issue can be reproduced, building the tests, with the command:
> > > make -C tools/testing/selftests TARGETS=iommu
> > > 
> > > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > > ---
> > >  tools/testing/selftests/iommu/iommufd_utils.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > I think it should be like this?
> > 
> > @@ -1042,15 +1042,12 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
> >                         .dev_id = dev_id,
> >                 },
> >         };
> > -       int ret;
> >  
> > -       while (nvevents--) {
> > -               ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> > -                           &trigger_vevent_cmd);
> > -               if (ret < 0)
> > +       while (nvevents--)
> > +               if (ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> > +                         &trigger_vevent_cmd))
> >                         return -1;
> > -       }
> > -       return ret;
> > +       return 0;
> >  }
> > 
> > And add a fixes line?
> > 
> > Jason
> 
> Thank you for the reply.
> I'm not sure the right behavior the test should have:
> - in the version you proposed, when ioctl() returns a positive
> value the loop ends and the next tests are skipped.
> - in the original version, if the function ioctl() returns a
> positive value the loop continues with the following tests.
> 
> Which one is the desired behavior?

Sorry it should be !ioctl()

The ioctl will only return 0 or -errno

Jason
