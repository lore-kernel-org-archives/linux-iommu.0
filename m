Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34520E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 08:09:10 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id z1so2606817plb.1
        for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 01:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rdXFs9dhHEmYQ1p1ijyoJFheXKNT53wMg7gaHyHajRs=;
        b=CMwx5eWilpke9A9U9PysLhgq3oj9UQNtzcPAIT+GD2mwU7iJ5D9avNU4vepTupSqT5
         Ry3WSe6U/gq91OuuORRb/PwxDxIV46EJ7yJtaxAgQnMfIv3ns8Y76socd7HtbYnes/vY
         gibUanTNA1O/GuZaS6JvJ41aRLNRg6pFANQTP24fE9L2XNNlM00uKjaaYS59npH5iPf1
         e6OGfvh9tPZwT4KJuDGDUYA5y0SfexTeU8QJaDPgdkA+SzVPJIZb666muYMf6uLfXwSr
         Hp/flc16jmPROVMcXhQsS+ZXEY0+VF+sPF6rWzjq8zenyPKrFXYq/ExiPuHJc85+s8F0
         1yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdXFs9dhHEmYQ1p1ijyoJFheXKNT53wMg7gaHyHajRs=;
        b=Qw2KymbeWfDlo8HCEcLEaZynjS2jK8bGYFOO2nECfg5bEqbfqAAViAa4/WK7ccA90r
         QACH//sitdP3k57hf+37s2jk1HPVIMSUYEu8AHffO0oxk6EPKQBFk+nTWnxEd9V3/Jdk
         /3b3avaphXXr/w0DY3wrQXAuPf8LSVwU23lrUpZa8tdIRqlpKi/+6oIPuURv4lHpplbB
         1p/8X9CdgXRB+W7hZdE0GhGkPrpsQuR8WYVD4hxadjTunxa1c3HXRW/DOLmWGHIp+UIq
         GoYxOKKrT+8ijiiyM36ucOcJuIrHflsbjsy9YUEyDedpYZn5KNeE2WbV4PlgoMLN6Sbt
         tUZA==
X-Gm-Message-State: AJIora91hJxR1dqdaQSF9R8keXLvd2+M0+2AxtJIfPW+JEHp0eaL1Mom
	KzmpdQka+tMyRSAuXC+of/o=
X-Google-Smtp-Source: AGRyM1srfbhQP54d3VOBFEBlurpmpSM2rwsylrne55YbDoqcDEgAyDzopM+ftR3vmVuJpDXcCkXP2Q==
X-Received: by 2002:a17:90b:1bc7:b0:1f0:34e2:5c86 with SMTP id oa7-20020a17090b1bc700b001f034e25c86mr13954875pjb.136.1657872550151;
        Fri, 15 Jul 2022 01:09:10 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id a5-20020aa78e85000000b00525b61f4792sm3073193pfr.109.2022.07.15.01.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:09:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 601A51008E0; Fri, 15 Jul 2022 15:09:06 +0700 (WIB)
Date: Fri, 15 Jul 2022 15:09:05 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Yicong Yang <yangyicong@hisilicon.com>
Cc: gregkh@linuxfoundation.org, alexander.shishkin@linux.intel.com,
	leo.yan@linaro.org, james.clark@arm.com, will@kernel.org,
	robin.murphy@arm.com, acme@kernel.org, peterz@infradead.org,
	corbet@lwn.net, mathieu.poirier@linaro.org, mark.rutland@arm.com,
	jonathan.cameron@huawei.com, john.garry@huawei.com,
	helgaas@kernel.org, lorenzo.pieralisi@arm.com,
	suzuki.poulose@arm.com, joro@8bytes.org,
	shameerali.kolothum.thodi@huawei.com, mingo@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, prime.zeng@huawei.com,
	liuqi115@huawei.com, zhangshaokun@hisilicon.com,
	linuxarm@huawei.com
Subject: Re: [PATCH v10 7/8] docs: trace: Add HiSilicon PTT device driver
 documentation
Message-ID: <YtEgoZveaZJ3a7+4@debian.me>
References: <20220714092710.53486-1-yangyicong@hisilicon.com>
 <20220714092710.53486-8-yangyicong@hisilicon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220714092710.53486-8-yangyicong@hisilicon.com>

On Thu, Jul 14, 2022 at 05:27:09PM +0800, Yicong Yang wrote:
> +1. Tx path QoS control
> +------------------------
> +
<snip>
> +2. Tx path buffer control
> +-------------------------
> +

Shouldn't Tx in the headings above be lowercase (tx)?

> +1. filter
> +---------
<snip>
> +2. type
> +-------
<snip>
> +3. direction
> +------------
<snip>
> +4. format
> +--------------
<snip>
> +5. memory management
> +--------------------
<snip>
> +6. decoding
> +-----------

I think these headings above should use title case instead.

Anyway, the documentation (htmldocs) builds successfully without new
warnings.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
