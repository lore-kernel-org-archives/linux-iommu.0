Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D845312BEB8
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124536; cv=none; b=qNGZADFC6TVLHcvsB7UysKUiER23AzrL4Oqw1lW6AJ26W2wSRUWyolGvw2sUobKhpIjYBs4351hcwS+qQlT5t1kz223JMn/+h6ksjwvo2JCmhf34XqEduxrOd4n5Q48VfU4Kooytj90FJBSx1yj0DSkdCpsdiOhpfeZBazJFWmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124536; c=relaxed/simple;
	bh=JX0XCKXr1thgDPxaTecjtKr6rIsRQAHKTIazy9OBhDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7VZsiaWmxh5B8Rd605vpzaee1r33ZLxZ5/x3qAqyUd79CXWFC7MEr43FBEuXqJKE/gaKgfwdY5iEDB1hxWUcauUcGFgpbMQMlRx2nXrp0hScoZPC5YphALsCnAG6jqU/Au9dvxWvTjBkFRKyS9FkKF+qY688aefUf6mDqBl7Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BWFdGDvn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BWFdGDvn"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so3485200b3a.2
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715124534; x=1715729334; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt8XgRQm+eA+VmBxGqEcvvy66oE9R2AfbLeL3WkCPuU=;
        b=BWFdGDvn3yKmpoPvhqSNjfqGhfnOhm0OoJJFDdsIhjMdD8Q6I/aC5xEE49u5C0Uyxt
         A+hjsquwJpgP+zBWERVR1hfzNUoL+b1zTbGOTohRgAjrNZV0euiLRtIB5bU1wBWuDcTz
         0N/iIVCnL9h3I23UlDrGltQ66n+U7K0lvPkZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715124534; x=1715729334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt8XgRQm+eA+VmBxGqEcvvy66oE9R2AfbLeL3WkCPuU=;
        b=WfRAb8bjS+KkdwJI4bYL4EOJkTMbOl3IDUi5mMyeXGcVOT2ucnMpEKYy057j8dfLim
         GnXqk/7txc0HWJDf0DUXwR7ue+tS4lhGfllJVkxZyXyNKqa5rxnCLJwUH6ar7XyTbxJC
         ZvNhTkJ0nwzQK7+Px1YTe7+9tbsuf/VmFE0gHADxtT+N8Czd7zlpz6//8Wao9gbZfpXm
         2O6aFwaFRW4o1dobwRTXRVFVJlfvZT11bdS0UuGX01mA7uxqaOfzw2eiy+MtcWH5DxaY
         +I48rIqAHCFKBAyyRLYs4GmDSILSQcm2jVpoWX/YKpvHFP2R+kiJZV9IjV5K4+jH8zcY
         Hyhw==
X-Forwarded-Encrypted: i=1; AJvYcCVkH+6CQIZJsErPP38s3mZCvFEZfWWQMkIbTyGqEgdZhInYPCJAKxb8+NXRp52GaqjWJ4TFYY0r84HQFrhsFZ03mwkfdJU=
X-Gm-Message-State: AOJu0YzXixenLNyIi7xcsU5Wr/2UZAiV9nGOQ6kn4glUkqTRGMT47Qh1
	nC+U0sKMbw8FjGUwShSEUFLwWwqcoZbR9acD3inydqBtGSOT/Ev+sy+1nnYfcw==
X-Google-Smtp-Source: AGHT+IElkYKkPF9F5WlZiOfJXRbgeCSMUqbJ3Z1JrZ5HzzcuDvdHCUlR3LVeoTae63dQgTdtTlamYA==
X-Received: by 2002:a05:6a20:9f88:b0:1ad:6c5:4ea1 with SMTP id adf61e73a8af0-1afc8db5479mr1525582637.41.1715124534335;
        Tue, 07 May 2024 16:28:54 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 60-20020a17090a09c200b002b624b0161fsm80422pjo.19.2024.05.07.16.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 16:28:53 -0700 (PDT)
Date: Tue, 7 May 2024 16:28:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Edward Liaw <edliaw@google.com>
Cc: shuah@kernel.org, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Seth Forshee <sforshee@kernel.org>,
	Bongsu Jeon <bongsu.jeon@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@android.com, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-input@vger.kernel.org, iommu@lists.linux.dev,
	kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-actions@lists.infradead.org, mptcp@lists.linux.dev,
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Define _GNU_SOURCE for sources using
Message-ID: <202405071628.7F8C3EC@keescook>
References: <20240507214254.2787305-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507214254.2787305-1-edliaw@google.com>

On Tue, May 07, 2024 at 09:38:25PM +0000, Edward Liaw wrote:
> 809216233555 ("selftests/harness: remove use of LINE_MAX") introduced
> asprintf into kselftest_harness.h, which is a GNU extension and needs
> _GNU_SOURCE to either be defined prior to including headers or with the
> -D_GNU_SOURCE flag passed to the compiler.
> 
> v1: https://lore.kernel.org/linux-kselftest/20240430235057.1351993-1-edliaw@google.com/
> v2: add -D_GNU_SOURCE to KHDR_INCLUDES so that it is in a single
> location.  Remove #define _GNU_SOURCE from source code to resolve
> redefinition warnings.
> 
> Edward Liaw (5):
>   selftests: Compile kselftest headers with -D_GNU_SOURCE
>   selftests/sgx: Include KHDR_INCLUDES in Makefile
>   selftests: Include KHDR_INCLUDES in Makefile
>   selftests: Drop define _GNU_SOURCE
>   selftests: Drop duplicate -D_GNU_SOURCE

It's a lot of churn, but I don't see a way to do it differently. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
