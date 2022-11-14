Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCBC4C78
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 13:59:07 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id k8so18437661wrh.1
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 05:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqBw4uJGnVX3z4DPc2jSDRa31QQsaamARtV+B+AB37w=;
        b=I7Fw3dN6D0oNium9zGsQ62LEfFU4SE1vaX9XCyYFpUrFcSXsm2shigs3JygwvRsT59
         6nb/zBZCTEfshXa1JokpyFh4PAPalnj2bk1fgyi4v4Ndjp/PzH/Vq8nJ7V223yIPuEmc
         AWyQF3mkU0g3mDxpcqwfYAu8PEqgIN8k5TpQiC7Xjus28Gf52gxBsvQfMHCLp5CoH6eP
         OGU/xaCAI/b5rsttbSzVp7uvCqdfMzTzxXZOdq9Ezt10gYbGSael2aMusvOC7S9kyikR
         2J7QIU1EhAxSKXxn11PIjreg3q2eq2PwvKxiRH/rpj1OREKlN54Txu4ycsGrbXs7dHSn
         Iu0w==
X-Gm-Message-State: ANoB5pkSWRLBUi857gCs302QNbuUYrO6Imspg9xobZXh7ocALtjjH/5G
	lUCJGZb346xaKjlFXBMzH4I=
X-Google-Smtp-Source: AA0mqf6sWl3Y3ybLQX3gzt/fpnJa5lC5OeEgLBiKOLq94WSSK5qCRn5EQdT6WADCZXcRKVREv3mgyQ==
X-Received: by 2002:adf:fc8c:0:b0:235:9aae:35a6 with SMTP id g12-20020adffc8c000000b002359aae35a6mr7279816wrr.686.1668434345461;
        Mon, 14 Nov 2022 05:59:05 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g7-20020a056000118700b0022cd0c8c696sm9447356wrx.103.2022.11.14.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:59:04 -0800 (PST)
Date: Mon, 14 Nov 2022 13:59:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Sunil Muthuswamy <sunilmut@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Message-ID: <Y3JJpyvCcrRZfJkV@liuwe-devbox-debian-v2>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
 <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <Y26F+H1SuJrad3Ra@liuwe-devbox-debian-v2>
 <BYAPR21MB168819214A20DF2E4835E763D7009@BYAPR21MB1688.namprd21.prod.outlook.com>
 <2f721208-d169-2baa-fa1f-b8450e80ddd7@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f721208-d169-2baa-fa1f-b8450e80ddd7@linux.microsoft.com>

On Fri, Nov 11, 2022 at 02:53:59PM -0800, Nuno Das Neves wrote:
> On 11/11/2022 9:58 AM, Michael Kelley (LINUX) wrote:
> > From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 9:27 AM
[...]
> 
> I've tested this patch on these Azure SKUs:
> - Standard_D2S_v2 (intel xapic)
> - Standard_D4ds_v4 (intel xapic)
> - Standard_D4ds_v5 (intel x2apic)
> - Standard_D4ads_v5 (amd xapic)
> 
> I've tested with linux Dom0 (nested hyperv root partition) and as a
> regular L1 guest.
> 

Okay. I think your tests are good.

Michael, do you have any further concern?

Thanks,
Wei.
