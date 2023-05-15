Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C68836
	for <iommu@lists.linux.dev>; Mon, 15 May 2023 14:36:12 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-53404873a19so1147380a12.3
        for <iommu@lists.linux.dev>; Mon, 15 May 2023 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684161372; x=1686753372;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntle7Mc0MN09Ld4JSB2zHnjwzKKJ2xLWcbwccUINeWM=;
        b=nmpPkLbkHeWzrNUYIBgGFtDeWZrt9C1ULqbYHO7f3h/8Rozghdl8hEcHeNcKQkbTlG
         zADuBhj4lbPnYGD8y9sfS2D+zwgCOyNhxCHNtW1op6PeVK3aiuq4zlzeYQvUA28CJK6A
         3faxbTFV4s9D85ojUIQ+o+ptrFpllMArk8nNfCl3GnS2e3QJST0XWRxMHnW/0vpfgned
         //KOYuh+4ZkNpexBLsdOZfUrPTcSn276Nmt3xBHXEGTsWs6VRzquyRJHGZvncJT0hSd4
         qCNkxCZ3A9UIDtDzZJrZupk0r8lpurw1ZMdYnFvm5xR+qi/kyrRcfUe1UHTveEBeGVOl
         zU3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684161372; x=1686753372;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ntle7Mc0MN09Ld4JSB2zHnjwzKKJ2xLWcbwccUINeWM=;
        b=E18H0OwequXwf/RcsDOXq57/WTvkYVyYu36FwbxVY2tmU5cnbhcqb+g8ysCzkcNW/D
         fms9XZggSGdaEeQHIsGCFU+O0DqyJr9xF82Aott+7Tydl1aUO2ua6kfwzFbikxzTpa0r
         wSdEe0ODIVFP/jq9//m30c3qNKusgaIHhUfRzbp1xFdGiR1qFZLIY6/HipKxw6mrjlpZ
         1TLSrEArcW9Jz6zGDpyYDZdPA6VxC5VXH082qkDH0RAszI0Xsexp12v6QUwTppiu4Jx/
         pFc57nDoBWosg1lT1Xl3qbWJ1ge5otqBw0ip+2SqX1GvmIdz3bnRXhlJ2XJA3JcI5OCc
         bTTw==
X-Gm-Message-State: AC+VfDwacLKbCF7HOfTwtSk3Vwvlyh0v3uQYILpWWNhQx1wg0m47+sw8
	ViwxgsJ4rff7+WwmMp7wAFY=
X-Google-Smtp-Source: ACHHUZ5Y1IBpWDwTz6WkQ1oOqRQ0CqOq276XS/52HNucim7sFHfLFQo4MIjL/je6cCeGa2eTmGpHdw==
X-Received: by 2002:a05:6a20:9146:b0:105:393b:5dff with SMTP id x6-20020a056a20914600b00105393b5dffmr9261541pzc.16.1684161371517;
        Mon, 15 May 2023 07:36:11 -0700 (PDT)
Received: from [192.168.0.115] ([113.173.119.15])
        by smtp.gmail.com with ESMTPSA id a5-20020aa780c5000000b006439bc7d791sm11899633pfn.57.2023.05.15.07.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 07:36:10 -0700 (PDT)
Message-ID: <e8a87c2b-a29a-ccf9-49c6-3cfceaa208bb@gmail.com>
Date: Mon, 15 May 2023 21:36:05 +0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
 Wan Zongshun <vincent.wan@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
From: Bui Quang Minh <minhquangbui99@gmail.com>
Subject: amd-iommu: get_highest_supported_ivhd_type question
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello everyone,

Since this commit 8c7142f56fedfc6824b5bca56fee1f443e01746b (iommu/amd: 
Use the most comprehensive IVHD type that the driver can support), 
amd_iommu driver can support IVHD type 0x11 and 0x40 beside old type 
0x10. This commit introduces a new function to determine the appropriate 
IVHD type

	/**
	 * get_highest_supported_ivhd_type - Look up the appropriate IVHD type
	 * @ivrs          Pointer to the IVRS header
	 *
	 * This function search through all IVDB of the maximum supported IVHD
	 */
	static u8 get_highest_supported_ivhd_type(struct acpi_table_header *ivrs)
	{
		u8 *base = (u8 *)ivrs;
		struct ivhd_header *ivhd = (struct ivhd_header *)
						(base + IVRS_HEADER_LENGTH);
		u8 last_type = ivhd->type;
		u16 devid = ivhd->devid;

		while (((u8 *)ivhd - base < ivrs->length) &&
		       (ivhd->type <= ACPI_IVHD_TYPE_MAX_SUPPORTED)) {
			u8 *p = (u8 *) ivhd;

			if (ivhd->devid == devid)
				last_type = ivhd->type;
			ivhd = (struct ivhd_header *)(p + ivhd->length);
		}

		return last_type;
	}

As the name and comment suggest, the driver is intended to use the 
highest IVHD type provided in ACPI table. However, looking at the 
implementation, I see that it chooses to use the last IVHD type of the 
first devid appears in the ACPI table. Are there any reasons behind this 
implementation?

Thank you,
Quang Minh.
