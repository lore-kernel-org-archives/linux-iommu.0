Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3813239
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpjXx0I9"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso7348230a12.2
        for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698674645; x=1699279445; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+oNiOzVWb1OPayLI3UpcZtoHUryNLF1OMI1H1r1pii4=;
        b=hpjXx0I9wVpn6/SfTYyPCJwEllTvFduAcO666COH1tW8cuGiPR0XYI7CAwhlr4MJPh
         /3nhW7sx0x9fsE80+ynCzzB6GfJqUpMEywKZyE4xLHDr6pznP3cEGWoThxAD2N0fBR8G
         7rVS03dZxcLUEjjZ2hDS+53yB8tsr/owJEnzbVKJgRHleg4xUVvYXDVVaxitX6dBeg2M
         ZP8CJo3ZNSd8KBvJ/sY9030P6Gqk+nRmqORCxffDhn/TstY48nAwiOGHCGBFTqQEqe13
         N0Q8ITwd8sRi/24plomvQjiz2kCchlcE6VwynMBI7pxtOWtOwFmG7aVOXudmVbhDUF1e
         7syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674645; x=1699279445;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+oNiOzVWb1OPayLI3UpcZtoHUryNLF1OMI1H1r1pii4=;
        b=nrhMoMPHpAy/T+y7aUuuC8JdX7CfLF+DVbn9gWUY+xips7T524lcKSSBgHi1wEF9sn
         ERl0E1spNPlhgsMVb46EkLACTuaHldd852qIm+w26WbrgJDuYNaFZV3NiAPA8Uee8yQJ
         j/uV9Mehhk2mGAsJIDFPce/CKeQJUVA31CbhLD7di9OOX1vcJwWcR6p4mqU+XaRgp6SN
         oeQqiSzNtxxJ9RKeZxPNRRzzvAjan/aDoIy5F6KIEwOeOXAN85FXYFhPYb+jrdbqPwtm
         KZiU8bwaqcfpzQMNh2wnDFQPkXQLcY6ZCGMQhohkbS8PVI/gcZbPMqeE2BeHDoH+SuYY
         Sy3w==
X-Gm-Message-State: AOJu0YyAgjHA34jD/S4wHX1u4XCU3ruc5W+wWmLTv8m58eMag8Nq5L0b
	6c3Mk5bmnB6zJ9WmaEsGGK8=
X-Google-Smtp-Source: AGHT+IGuB54s6jt5VweeRbOkpv1wIU19siV44qKlRwvJUPLaaNQIqUU4r7Z2qBf99J+gcTg2aucBeQ==
X-Received: by 2002:aa7:d70e:0:b0:53e:fd81:67ab with SMTP id t14-20020aa7d70e000000b0053efd8167abmr7583675edq.6.1698674644917;
        Mon, 30 Oct 2023 07:04:04 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc31:8900:5db7:a938:1060:35a3? (dynamic-2a01-0c23-bc31-8900-5db7-a938-1060-35a3.c23.pool.telefonica.de. [2a01:c23:bc31:8900:5db7:a938:1060:35a3])
        by smtp.googlemail.com with ESMTPSA id n27-20020a5099db000000b0053116e45317sm6278564edb.44.2023.10.30.07.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:04:04 -0700 (PDT)
Message-ID: <a3cc5420-8b0e-4336-accd-78557b5f8f46@gmail.com>
Date: Mon, 30 Oct 2023 14:50:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] r8169: Coalesce mac ocp write and modify for 8168H
 start to reduce spinlock contention
Content-Language: en-US
To: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
 Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, nic_swsd@realtek.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marco Elver <elver@google.com>
References: <20231029183600.451694-1-mirsad.todorovac@alu.unizg.hr>
 <20231029183600.451694-3-mirsad.todorovac@alu.unizg.hr>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20231029183600.451694-3-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.10.2023 19:35, Mirsad Goran Todorovac wrote:
> Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify() in
> the startup of 8168H involve implicit spin_lock_irqsave() and spin_unlock_irqrestore()
> on each invocation.
> 
> Coalesced with the corresponding helpers into r8168_mac_ocp_write_seq() and
> r8168_mac_ocp_modify_seq() with a sinqle paired spin_lock_irqsave() and
> spin_unlock_irqrestore(), these calls help reduce overall spinlock contention.
> 
> Fixes: ef712ede3541d ("r8169: add helper r8168_mac_ocp_modify")
> Fixes: 6e1d0b8988188 ("r8169:add support for RTL8168H and RTL8107E")
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: nic_swsd@realtek.com
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20231028005153.2180411-1-mirsad.todorovac@alu.unizg.hr/
> Link: https://lore.kernel.org/lkml/20231028110459.2644926-1-mirsad.todorovac@alu.unizg.hr/
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> v5:
>  added unlocked primitives to allow mac ocs modify grouping
>  applied coalescing of mac ocp writes/modifies for 8168ep and 8117
>  some formatting fixes to please checkpatch.pl
> 
> v4:
>  fixed complaints as advised by Heiner and checkpatch.pl
>  split the patch into five sections to be more easily manipulated and reviewed
>  introduced r8168_mac_ocp_write_seq()
>  applied coalescing of mac ocp writes/modifies for 8168H, 8125 and 8125B
> 
> v3:
>  removed register/mask pair array sentinels, so using ARRAY_SIZE().
>  avoided duplication of RTL_W32() call code as advised by Heiner.
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 26 +++++++++++++++--------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f4a1d1a74b8b..29ee93b8b702 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3231,6 +3231,21 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  		{ 0x04, 0xffff,	0x854a },
>  		{ 0x01, 0xffff,	0x068b }
>  	};
> +
> +	static const struct e_info_regmaskset e_info_regmaskset_8168h_1[] = {
> +		{ 0xe056, 0x00f0, 0x0070 },
> +		{ 0xe052, 0x6000, 0x8008 },
> +		{ 0xe0d6, 0x01ff, 0x017f },
> +		{ 0xd420, 0x0fff, 0x047f },
> +	};
> +
> +	static const struct e_info_regdata e_info_regdata_8168h_1[] = {
> +		{ 0xe63e, 0x0001 },
> +		{ 0xe63e, 0x0000 },
> +		{ 0xc094, 0x0000 },
> +		{ 0xc09e, 0x0000 },
> +	};
> +
>  	int rg_saw_cnt;
>  
>  	rtl_ephy_init(tp, e_info_8168h_1);
> @@ -3271,15 +3286,8 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
>  		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
>  	}
>  
> -	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
> -	r8168_mac_ocp_modify(tp, 0xe052, 0x6000, 0x8008);
> -	r8168_mac_ocp_modify(tp, 0xe0d6, 0x01ff, 0x017f);
> -	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
> -
> -	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
> -	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
> +	r8168_mac_ocp_modify_seq(tp, e_info_regmaskset_8168h_1);
> +	r8168_mac_ocp_write_seq(tp, e_info_regdata_8168h_1);
>  }
>  
>  static void rtl_hw_start_8168ep(struct rtl8169_private *tp)

For these few calls I don't really see a benefit in the change.
Instead it makes the code harder to read.

