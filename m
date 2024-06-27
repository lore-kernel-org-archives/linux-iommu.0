Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B019AA47
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512089; cv=none; b=X82GG4RafkYUEa1jmG6a7GmsJWeSPzrikAvWCxC2LC9y8sWVJV7kOYiUvF716xSIeKHsL4PEj5SsNQ+NRLNiFfT6FeldOoc/2uPGwOZ3GccvF3+OOiYWzKpFE6FcFiUVCxq9bNZ5nxGaswd756dsMQSJ5RGC1hz/emtzWgDMxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512089; c=relaxed/simple;
	bh=2cK5AxOV9l+UMy4wzDeUFqdeQNcGCtOHicEYrQngggg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxE4Kq1md5Ppv4mwHLvuXQvx19U9KUnPM+3Hxuyd9dV47dKRYZx8W4VId5izCdzxChbZYzouCq0IpHET77CmrWRy+JZO1m7U5KGoCvuKGInsiIwrGbolv3CeRo7eKP1yLhTABTvL4JkbzWfQlF+eDMxIyfgo0hLisj+RNNCD5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UAh/0PxT; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UAh/0PxT"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f3d395dcf9so6276339f.0
        for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719512085; x=1720116885; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMHKqtsViAFQ8XOx3exriIx8afAjHEvNWX9sCBFwKMs=;
        b=UAh/0PxTbsXy0OWp0oVG7z6/8ZLbx1EJ9RMD5R8AVtDCHwF61fxZRejzL6xLn4sugq
         BUXJUcKjiHp+AuRE5b1TgYf/Gr2Y4gBeEinztjfCWhCpE6EpGL0cr2vDNXX9FQ+55V3T
         pZACLcPKnyMZthZk0KJ+Hnpnz+duTBjNSYMxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719512085; x=1720116885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMHKqtsViAFQ8XOx3exriIx8afAjHEvNWX9sCBFwKMs=;
        b=CRnjtq4PN9rqzNmfbx6d1+3Zh+9fsmGIJziFXN3kBR4PA7RQWUVPboEVSl8Ezvth/E
         d2Mrz1KUjnQzyZYIdPzRMBb1t0tTteU63r85BA80qP2uPC5/UnlNFxxcMP2Ksj6VdD3s
         cISfwBry2sl9Or3ZJe3uKhWWPztrl8eg7oz5ngf80rE9yv53RQ+x8rRSDbcAVxFeypOb
         /laLrlMzUVqi8T120/xDQeEJYFiOYSucr0oCXa1itdqeGailZV3EsAO/Y00+mQzrv3In
         IfShqdD1UJg+aBR7Lv9xw1D3oNYxCsKFqYYrq+ZUGToygdFv/3Za6U1PX4PWkQ8RoDu0
         UwzA==
X-Forwarded-Encrypted: i=1; AJvYcCXMj2QQhMz8I9oI3/rdzByxe1MI6XXtGqHoh67+jtVvAl8Cplv+BCySb2mk9IQjvAbWxft7X3+mduasCoOTcH34ycFBxrQ=
X-Gm-Message-State: AOJu0YyIA7/3qxX9A4dKFf2C2vh58s2bDT0d+1yT72F7+QL8hhkiFAUf
	1fFuuAkNn1DS4FiwC61k2L7T07KQULKyTT6Qga2doYWFL31Si1fKUzANAuG4Mb8=
X-Google-Smtp-Source: AGHT+IFUG5O1SrOnPJRNTLD5kODnctBl78frxmuDBYLRyoOk4cGdplKcVn3bQ6BYVahLxGENnJxatg==
X-Received: by 2002:a5d:984e:0:b0:7f3:9dd3:15bf with SMTP id ca18e2360f4ac-7f39dd317famr1350449739f.0.1719512085576;
        Thu, 27 Jun 2024 11:14:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f61ce9d654sm2994739f.13.2024.06.27.11.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 11:14:45 -0700 (PDT)
Message-ID: <af55d4ae-fefb-4235-a175-83e947ec4c25@linuxfoundation.org>
Date: Thu, 27 Jun 2024 12:14:43 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] selftests: Centralize -D_GNU_SOURCE= to CFLAGS in
 lib.mk
To: Edward Liaw <edliaw@google.com>, linux-kselftest@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, usama.anjum@collabora.com,
 seanjc@google.com, kernel-team@android.com, linux-mm@kvack.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sgx@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240625223454.1586259-1-edliaw@google.com>
 <20240625223454.1586259-2-edliaw@google.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240625223454.1586259-2-edliaw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/24 16:34, Edward Liaw wrote:
> Centralize the _GNU_SOURCE definition to CFLAGS in lib.mk.  Remove
> redundant defines from Makefiles that import lib.mk.  Convert any usage
> of "#define _GNU_SOURCE 1" to "#define _GNU_SOURCE".
> 
> This uses the form "-D_GNU_SOURCE=", which is equivalent to
> "#define _GNU_SOURCE".
> 
> Otherwise using "-D_GNU_SOURCE" is equivalent to "-D_GNU_SOURCE=1" and
> "#define _GNU_SOURCE 1", which is less commonly seen in source code and
> would require many changes in selftests to avoid redefinition warnings.
> 
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>   tools/testing/selftests/exec/Makefile             | 1 -
>   tools/testing/selftests/futex/functional/Makefile | 2 +-
>   tools/testing/selftests/intel_pstate/Makefile     | 2 +-
>   tools/testing/selftests/iommu/Makefile            | 2 --
>   tools/testing/selftests/kvm/Makefile              | 2 +-
>   tools/testing/selftests/lib.mk                    | 3 +++
>   tools/testing/selftests/mm/thuge-gen.c            | 2 +-
>   tools/testing/selftests/net/Makefile              | 2 +-
>   tools/testing/selftests/net/tcp_ao/Makefile       | 2 +-
>   tools/testing/selftests/proc/Makefile             | 1 -
>   tools/testing/selftests/resctrl/Makefile          | 2 +-
>   tools/testing/selftests/ring-buffer/Makefile      | 1 -
>   tools/testing/selftests/riscv/mm/Makefile         | 2 +-
>   tools/testing/selftests/sgx/Makefile              | 2 +-
>   tools/testing/selftests/tmpfs/Makefile            | 1 -
>   15 files changed, 12 insertions(+), 15 deletions(-)
> 

Andrew,

I am seeing merge conflicts with mm and exec tests. Might be
better to have you take this through your tree?

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

