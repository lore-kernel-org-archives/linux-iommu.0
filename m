Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B524DCF9
	for <iommu@lists.linux.dev>; Wed,  8 Oct 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759929875; cv=none; b=tQ2xctjiKxx9GuLos0WxK27Y5XhqTOFDeQHF/RCsqo4lFkJynv04+L/uGl/RDU5gKdHv7vT7qAkxCqqjyn3AibOVYleZaKrYN8YvCVpdCyR33A8JBamcdVh17Tl3ZutNrGhHcHmMiVWUQMgMwH3mxePVMqw7GO6lXjH77inZa/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759929875; c=relaxed/simple;
	bh=+z4cw7Kh0UDzc/Mzt4faADLbEJpWktNXzAB2U/Vl3lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/bi+6Wc2xGYKHp6ttRkr/0181PBVRJ8phLsd7NbPB5v/cAtMRNapakxyhy8aFGmxiwWIUb528uTEP1LhA6YNuwLDroxB7Xs2VDmtVgKITluo5mDmoK8aBCyceUtL3256Pw4wc5nqIDnZljA3p9kEkyFKjiggsSbvlGXEQ6pl9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RuAeVXIU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuAeVXIU"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63994113841so6376688a12.3
        for <iommu@lists.linux.dev>; Wed, 08 Oct 2025 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759929872; x=1760534672; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BI/TCoi4LzxSA8XfIjZuhJqyGS6WzPwjqlZF4XU4Rk0=;
        b=RuAeVXIU9gu9xbT5zgvZp7pA4svnOvS+Cg4mOmdk5M4mNB5ecmKDB06/tw+Z7hP62w
         vKpv1lxiRhCJysLGgmmDQh57OWebR/CNLlWssxeGpj2qpooAwFYvsCAoIviZUJ8Zh7Sy
         X0XT/IrC6roVTkLuxzCoSvIvKPQbfItbp6d0vX3PQ8jkRImcK7b+x5N4kwfTitxPngP4
         V7r+1H4JsaB4tzHN/VjUoBPbpXgu7nUE4UgMiS9WEYVAJKtgPanET0FAr7mpby1OZL0x
         9Xpgrfq8v6x46naC/8kMt5hU5vElER1nU3h6/+pT1HylaNnCL0wBrNu5fCqNgViRU4aG
         hrag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759929872; x=1760534672;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BI/TCoi4LzxSA8XfIjZuhJqyGS6WzPwjqlZF4XU4Rk0=;
        b=MSFZV0k5YzW5MU6veD0Y3nqogMEjVOPOrX+oMfQ81KKNYpXtL9oB6orlnsgHxI9TLR
         glBtRPINtW4B1C+CntArr2VPBxfQ0TCpOMPsMk4a0EDyIz3+sicUU6e8bT8DE70Gx76t
         pKiEvVrd3GciVq551VwRn08JsvtzY+evDudpU3ncJM4X6BhXAtIoUBjx2ob+41zWo/xW
         aSfYl4rrHQDAzX8PWUnhT9+pCRLzl8NP5EpVKPl25uthdrOkaVepvWylL9ds/V0k6CUg
         n0hNCJwUQx39KrmvLcOIA0rhsguMSH8J3r62wHhFpTVPEXZJHPzrUY1uQgLRBGTi96Np
         vEqg==
X-Forwarded-Encrypted: i=1; AJvYcCUpzD6vMwxmRhmBW8a2DnqA4fs4p9Dhumgar+9jSyX/HuHYaMucmTXWEBm9MJ6ALrsLFGYONg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgLLn+rCb1weH1LeZTHBJp7a7Y7hi1R3TyI/VqIlFZxdiUHKD8
	r1oPok5Y7WsQW2XQxDSFWsosrYvNy268QE3UAVBNvPTgXDerKLu+7ppd
X-Gm-Gg: ASbGncvm6b8PH2BRbRoEa2MUcKvbsafH215VjaLwVnnVAdhw0C3gjAYmJ/DmBhaLFq1
	Ckr9khV45hZeEz9ym2Wdky9lzQOzp0SIqmJWnGNVj58VAAJFThhcrE+dMjrcGlHHnjibz/pXYNZ
	QRA2ufOxHkopiB2n0KGeRu8prxOTK7C4Ogx3aVy8jaTjSK8Wif+5vODldXZeKwgpCrcu3GXp4oS
	jjMmaSMcKBmeIHP8NJTe0aVFO3zl7f7n5iMay0uI995wLGCabrDnG582XpF0RU8R/v7XlCdBY1X
	FZzKHT5PfyY7K36FN5OSD7fnE5Nn22dztcVLfOUUAxZe2ZExJy7R22GJR3LBPeUh6wgiEIzDYr4
	oF93ogUhWypMyY9R8H9AmDxR+K/wdRi2D7NzsHVDRkEwGZMW4BMZlI0ACjmb/SbsRwOFGL8Kbp4
	MfiFQJoYya9prmcgvOKkqNYe4RZUAPi3U=
X-Google-Smtp-Source: AGHT+IFoTe1GsKoLNfXidCZ8Czjg/nCNLCnzrvEUmCAiPJvugQ49+mFzHnMIpycIWZF3p+SyrTr4cg==
X-Received: by 2002:a17:907:948f:b0:b07:c90a:8ade with SMTP id a640c23a62f3a-b50aa08f896mr397894066b.20.1759929871888;
        Wed, 08 Oct 2025 06:24:31 -0700 (PDT)
Received: from alessandro-pc (net-2-37-207-41.cust.vodafonedsl.it. [2.37.207.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa040sm1650850166b.20.2025.10.08.06.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 06:24:31 -0700 (PDT)
Date: Wed, 8 Oct 2025 15:24:29 +0200
From: Alessandro Zanni <alessandrozanni.dev@gmail.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>, jgg@ziepe.ca, 
	kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix to avoid the usage of the `res` variable
 uninitialized in the following macro expansions.
Message-ID: <rfwgp73zuyctbjgxvdgs67gq7g6glfxdd5peimqjiw5inw5h4g@cgmif7gyplct>
References: <20250924165801.49523-1-alessandro.zanni87@gmail.com>
 <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc360969-c1af-4b87-a259-cc265a8d553d@linuxfoundation.org>

On Tue, Oct 07, 2025 at 03:28:29PM -0600, Shuah Khan wrote:
> On 9/24/25 10:57, Alessandro Zanni wrote:
> 
> Fix to avoid the usage of the `res` variable uninitialized in the following macro expansions.
> 
> ret not res?
> 
> You can simplify the shortlog "Fix ret unitialized warning" perhaps.
> 
> 
> > It solves the following warning:
> 
> Fix the following warning.
> 
> > In function ‘iommufd_viommu_vdevice_alloc’,
> >    inlined from ‘wrapper_iommufd_viommu_vdevice_alloc’ at
> > iommufd.c:2889:1:
> > ../kselftest_harness.h:760:12: warning: ‘ret’ may be used uninitialized
> > [-Wmaybe-uninitialized]
> >    760 |   if (!(__exp _t __seen)) { \
> >        |      ^
> > ../kselftest_harness.h:513:9: note: in expansion of macro ‘__EXPECT’
> >    513 |   __EXPECT(expected, #expected, seen, #seen, ==, 1)
> >        |   ^~~~~~~~
> > iommufd_utils.h:1057:9: note: in expansion of macro ‘ASSERT_EQ’
> >   1057 |   ASSERT_EQ(0, _test_cmd_trigger_vevents(self->fd, dev_id,
> > nvevents))
> >        |   ^~~~~~~~~
> > iommufd.c:2924:17: note: in expansion of macro
> > ‘test_cmd_trigger_vevents’
> >   2924 |   test_cmd_trigger_vevents(dev_id, 3);
> >        |   ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > The issue can be reproduced, building the tests, with the command:
> > make -C tools/testing/selftests TARGETS=iommu
> > 
> > Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> > ---
> >   tools/testing/selftests/iommu/iommufd_utils.h | 8 +++-----
> >   1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> > index 3c3e08b8c90e..772ca1db6e59 100644
> > --- a/tools/testing/selftests/iommu/iommufd_utils.h
> > +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> > @@ -1042,15 +1042,13 @@ static int _test_cmd_trigger_vevents(int fd, __u32 dev_id, __u32 nvevents)
> >   			.dev_id = dev_id,
> >   		},
> >   	};
> > -	int ret;
> >   	while (nvevents--) {
> > -		ret = ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> > -			    &trigger_vevent_cmd);
> > -		if (ret < 0)
> > +		if (!ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_TRIGGER_VEVENT),
> > +			    &trigger_vevent_cmd))
> >   			return -1;
> >   	}
> > -	return ret;
> 
> Hmm. with this change -1 is returned instead of ret
> 
> > +	return 0;
> >   }
> >   #define test_cmd_trigger_vevents(dev_id, nvevents) \
> 
> thanks,
> -- Shuah
>

This patch has a malformed title. Please refer to the patch called
'[PATCH v2] selftests/iommu: prevent use of uninitialized variable'.
But the typo `res`->`ret` is still present. Sorry for that.

About the fix, the assert test just checks if the return value is 0 or
not. That's why the variable has been deleted.
By the way, if we prefer to return also the error values, the patch 
v1 just solves the warnings returning the negative values.

Let me know which version is preferable.
Thank you,
Alessandro




