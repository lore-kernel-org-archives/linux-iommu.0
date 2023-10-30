Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD51773C
	for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGsaOZlD"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53f9af41444so7653145a12.1
        for <iommu@lists.linux.dev>; Mon, 30 Oct 2023 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698674647; x=1699279447; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJIuoAtLoMl+q/4kEIYB08eglQMbIbdPoKSZWjRcEyg=;
        b=OGsaOZlDypXgT+777fir0Af8ld5Y3Kn5gNvntwyPyubvlJjI5yKWy+zP5bOzUO2euV
         PExu/v/cQKr5pbuMpLNQ8n4khx+oQiG5pdXrdv+jZ5RmhMNxe7EZFBkiwXglVyAQMOfW
         jANTI9L8ZFZAWcHXK1ZJ8TgW0Qix1u4eMLvATOHMcnVBWjNKEMljeCmbh0f2R544R4xl
         lmYiDpAvzq8R5Pb/GGL6FIvnLOqnfAOTylDArKryIZhFa2iMqDGLBa0t8IMtQe2zpIu+
         plASB8rox3i/JRcgH1/O+LRhfS+W/L9QavxlwlbSovP9paH7OB5Iv7gnDX4icNqbhjT3
         4/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698674647; x=1699279447;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJIuoAtLoMl+q/4kEIYB08eglQMbIbdPoKSZWjRcEyg=;
        b=okFXYHfaR5z4srwngAD1UGb8d4IMmRUhEbkEgG99mdOA7flG/bvftY5mkgdQ9ID3Vr
         pDUi9Jozrmz3711brxsbdzEUnWmJ4KKqvkDLH/DzCTAwLYgb5zrS4L72iHJm3Yls2BeT
         QhgdONyhMuIefSUDVqsJciJsfjnOi7IFmrRnKnqqB4mQQfbV2ZjQTnrm8qBAlP/lA8Im
         YNSpW+a5NHkfTbRSJUSDvJz0FWCMYs83lDs6KanEIQ3FOKopleGLoHm9nZIClY8o5+5/
         FZMgiY6ZnaY7aHxxWBN77F37EQQYXg2wl46zW+WwlC9b/9lxSilTITHxDqSbYUOZn+ZE
         rCTQ==
X-Gm-Message-State: AOJu0YzVh84t8O6Id+RynvazZk97w78cwitpEpPIL+mq/YRFxde/nx5a
	tc5qDdDlW4hMMW5KoJDQSic=
X-Google-Smtp-Source: AGHT+IHVau6Kec0qtmxf+bOSjOD+i1u1+CfVGrz7rjebRK0fXmws6l+uxlMMss65WKxL21UvWcGQbw==
X-Received: by 2002:aa7:cc8c:0:b0:53f:738c:3eeb with SMTP id p12-20020aa7cc8c000000b0053f738c3eebmr7628802edt.28.1698674647338;
        Mon, 30 Oct 2023 07:04:07 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc31:8900:5db7:a938:1060:35a3? (dynamic-2a01-0c23-bc31-8900-5db7-a938-1060-35a3.c23.pool.telefonica.de. [2a01:c23:bc31:8900:5db7:a938:1060:35a3])
        by smtp.googlemail.com with ESMTPSA id n27-20020a5099db000000b0053116e45317sm6278564edb.44.2023.10.30.07.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:04:07 -0700 (PDT)
Message-ID: <459f8e54-419e-4e03-8c6c-250eba8889cc@gmail.com>
Date: Mon, 30 Oct 2023 14:51:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] r8169: Reduce spinlock contention for the start of
 RTL8117
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
 <20231029183600.451694-5-mirsad.todorovac@alu.unizg.hr>
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <20231029183600.451694-5-mirsad.todorovac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.10.2023 19:36, Mirsad Goran Todorovac wrote:
> Repeated calls to r8168_mac_ocp_write() and r8168_mac_ocp_modify()
> in the startup of RTL8168ep involve implicit spin_lock_irqsave() and
> spin_unlock_irqrestore() on each invocation.
> 
> This is avoided by grouping unlocked __r8168_mac_ocp_write() and
> __r8168_mac_ocp_modify() primitives enclosed in the explicit
> spin_lock_irqsave()/spin_unlock_irqrestore() pair.
> 
> Even if the lock is not contended, the check requires a LOCK CMPXCHG
> or a similar instruction, which prevents all cores from accessing the
> memory bus.
> 
> Fixes: 1287723aa139b ("r8169: add support for RTL8117")
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
>  drivers/net/ethernet/realtek/r8169_main.c | 24 ++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 27016aaeb6a0..50fbacb05953 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -3348,7 +3348,15 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>  		{ 0x19, 0x0040,	0x1100 },
>  		{ 0x59, 0x0040,	0x1100 },
>  	};
> +
> +	static const struct e_info_regdata e_info_8117_wr_1[] = {
> +		{ 0xe63e, 0x0001 },
> +		{ 0xe63e, 0x0000 },
> +		{ 0xc094, 0x0000 },
> +		{ 0xc09e, 0x0000 },
> +	};
>  	int rg_saw_cnt;
> +	unsigned long flags;
>  
>  	rtl8168ep_stop_cmac(tp);
>  	rtl_ephy_init(tp, e_info_8117);
> @@ -3388,15 +3396,13 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
>  		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
>  	}
>  
> -	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
> -	r8168_mac_ocp_write(tp, 0xea80, 0x0003);
> -	r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
> -	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
> -
> -	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
> -	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xc094, 0x0000);
> -	r8168_mac_ocp_write(tp, 0xc09e, 0x0000);
> +	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
> +	__r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
> +	__r8168_mac_ocp_write(tp, 0xea80, 0x0003);
> +	__r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
> +	__r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
> +	__r8168_mac_ocp_write_seq(tp, e_info_8117_wr_1);
> +	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>  
>  	/* firmware is for MAC only */
>  	r8169_apply_firmware(tp);

Same
