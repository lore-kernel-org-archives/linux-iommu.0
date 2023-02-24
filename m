Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2014.outbound.protection.outlook.com [40.92.59.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A3D3C23
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 22:00:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MmML3ReCRm9FOpdrCEKjJNiSI9XJ4dwdfsMD6rcReDC8u3q8BO2XLLndMNd/rrP0JTh4vGjgZCT1ZoghpWjMoXVK83AudXcj9Ti462aCo+OnYPD7IEmAS0FTGGe5OIvOjnSRJFQzODtSJrV6FFTi056Ro6NQ4GfQjvXfefyY7oUhye2lXZ6YsnJWu1gFZ0L2w1iZ2dnJBtwCQCQuwAbLm8k75LFZ5jOpbwf4rQ1kBleH1EOZvBnYRrvK469ly8VOw8SDHuYk4l102V+BW3AS+zN8EWaOlKgHpuneWHODOr6sX+YO/T7MEH+WcX8fePQy+yUkeozh0fsydWjWoDOdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uilPddUpLTwmhglHxLa0J3H0U5WbXnUkfvDWt+M9h0=;
 b=iO3BbpEvZIZp72rH3NYulf9zsi9diBevl0QHIiTyN1h1GccjY6pd/JzYlisbP2f7eayrjtJdh13MoAf/1S/TvpdlorvWYdC52u0OzfvVynQJl6KAjmF6IUjDW+5qwU7nGOzQIo1FKLqWXnrivp5FqgSUl4/9p5KILKh23MyZLzMPwEcBftE1OOhxdO1b2mYPUAR4pwP9Ke6AOVuRHjDrMDFp4KwNEsG+/O1QZM00vqisp/2K8Iib+sC1KRamKDq9sD+wl2N/y01RYAoMmeA/Y/jpKGaT2PhUlbtxrKKAOp0f4wXG2eu4qpbGVea9VM6oXt9tC98wSRiuqsLsfXIMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uilPddUpLTwmhglHxLa0J3H0U5WbXnUkfvDWt+M9h0=;
 b=DS435CQhLiAM2KdD3x3TgkGvvGu8umhTCJALq5FIhOp+386aS6odYVaKz1Q5ps0c2MXKRAvy84KxSHDvaRRI1IYyZvtCQgZRcqEPH/V7BMcl4PRFVUDN+eZXN3A+jcwYWwfu/d+ZWhC/JDBOwerXJug7p2JLlsOp7bMKb1/N4+LnKiLjVUcd5R0pLMSHrhgvIUSvo00un6pdMBUvKiozP4gxC9oY2aHd91xfhAEvkn21ByD7zymVzUg1QTlktFnbQ0fs+j3u7JsY91qRDHdVeQhz7o0Rc3VOcQw7TifWFUEcc5vUCrF3gU8sG5TFgapw00UduLSKxoDentJS7wm9yw==
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40e::16)
 by PAXP193MB2138.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 22:00:53 +0000
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::a948:f3d:75c5:1a0a]) by AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::a948:f3d:75c5:1a0a%6]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 22:00:53 +0000
Message-ID:
 <AS8P193MB20953101844220A5EEE2570ED2A89@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
Date: Fri, 24 Feb 2023 23:00:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: SR-IOV on ARM64 system with SMMU
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <c8366f3a-3eba-6a54-558d-c87350187793@arm.com>
 <AS8P193MB209596DC2B89931C57C565BDD2A49@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <77bf61fd-485e-7162-c0d3-c1bd7735deaa@arm.com>
 <AS8P193MB2095CD44400D95C79C262249D2A59@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <e182594b-5cdb-881d-59c8-a20dc90b62fb@arm.com>
 <PAXP193MB2105A8519929AD3E4A508F25D2AA9@PAXP193MB2105.EURP193.PROD.OUTLOOK.COM>
 <28ef1727-161d-1165-3878-08f7534f6e47@arm.com>
From: Martin Bayern <martinbayern@outlook.com>
In-Reply-To: <28ef1727-161d-1165-3878-08f7534f6e47@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [xMtJyzrerodC1K3jhSmoLCeSpOdV9E41iJYVTWka3wjhL2VEgePbE9pJ61vUGL32]
X-ClientProxiedBy: FR2P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::7) To AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40e::16)
X-Microsoft-Original-Message-ID:
 <f5fb2ab5-092a-1131-d298-f064cb95e333@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2095:EE_|PAXP193MB2138:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf44f81-863d-40bf-6204-08db16b298ca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	omvBaaY+JU/mY7vcDUzQDWL25fHac6Pgsoh9MepHsxDm5LsWfp9VUVAMEqG52BDt3BQBimW5aBBodTN4+X688JHKlKTPLqXu2Yk4JXkBmpOFnHedRVZegClHYI6riTDTa3g08hEl8/7gp0H5Ddev88bwv1fWtFqZ3K+AF952+NJnS3VD7nCLJD/AyMPuu+g+8tIkkm11LMdxEn5ypqblVEWZPawWRvSjR0zNMA94PIhUdaFk/ANSGYHRKpRySanS9iqGJGNvG5xYkMFg8GG29tPuAQ6DNGlynRTdBudvB+RG0MSXUFEJ4lJT5zeuV6dRQ420pWiWvqcrpACJxVuytwOS+HnjBM5X9+uH0K2gOlYQjvLEZD5q9i7nSrXu8waVve6k7/m6XDUF2rPP5mnfePO0DXr8isP7RyGn4m5Lhf+sjLG/CjmTmFE9ecpUppo1AQxUC5+GbrbDYGjq1dDWmw64RZ4+7wwdvlIzcAvWRr9ULDWFV8MX6XyXcHKOdTQARSMUFzy+LBIMywusHXk+4GaYx4tfLI+N0vmWl1f9j3ot7uT2EkXNkcLd6TQVHpotXcc8lu+MXnTb1hSR5ivOF15i7H/0bvaJLm/B/cULbygyP2rSivMpd3SypLhDm7Z934WXhrmV5Z6fLSRwbtdafA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnRqRXZ6WFJBNVJiYTNWWGFTR1FDak9LVGdXeWw4VzI0MkRFTWkxZ1NJUzNt?=
 =?utf-8?B?dFhiMHZSWEV3SVJWTlFia1RNZnd5R0FodFZnRTk2UGowMUlORnladkxERWdi?=
 =?utf-8?B?aUVscUZsLzcxeDFvM0dxQ2tiWDJGelphcUl2Y1ZmVTQzeFdaN0sreTFSN0FL?=
 =?utf-8?B?V1RiOWlWOHRvYWJjNXRoMUVUbTJrM1pPbmdDYVRqNUxYQzRlWkFNSnNJRThU?=
 =?utf-8?B?clZWaXlacHVkYmVPWk9kbGZQaUlZUWJIS0ZhLzg5TFJtT2NFYkt5a3ZyVTRM?=
 =?utf-8?B?NmM5VGxwOXIxdEdoVWRBRElIMC92eitYbWxkN01tYm53ZndycU5QN0E1dFd1?=
 =?utf-8?B?d1UvcjM4QXBDd3dEbTM1dXY3b2NPTWN2d0t3V3pSMzg5bHRjWUR3SStpWGw5?=
 =?utf-8?B?TVIxQXEzc2tMaWhsMjVGeWx0UXJRRS9mSzJFQzNEM2dWbHZuOFB3TnMzcGwr?=
 =?utf-8?B?WVI5VzJFem44M0tZeGtvTlhJRGJwTnA5UVJqeFhuS21lZHVscEs2bFBqaHZF?=
 =?utf-8?B?ZC9ZWURNU2Z6SjNRMlQ2WmxGSExCSDZxQUtoaDZFdG1QdEUzR2lYMUpEVlh0?=
 =?utf-8?B?U1I0aVJUN0Z3bTB6K1lzcTF5WTQydEhQQi95ZE4zcXFUMnlhMFIzWkpyaXVy?=
 =?utf-8?B?aGZ3ckNEV040YjkwdlIxUXA4VThmZ3MzeTI0WHdLaVRPczJsQlRLQ2tjWnhU?=
 =?utf-8?B?WVh4SnFnZ2E2RlNjeDBFR2h0elZkT2dZZHdxS0RhekN0cVZHUXdScjdKMUdR?=
 =?utf-8?B?MU1wT2ZScGdCbTFKWCszZ2ZoNjcvQnQ1ai93T3pYa2REODRKMjlXTksyL0Ni?=
 =?utf-8?B?aWZ0VEo0V3IydUlHQVVEenF6N29USE81SUREVGE1MjlSbTY1SU5NR2VLZTlY?=
 =?utf-8?B?YkI2em1ZVEJadkxWMmJxWFRWZXBCb3pSc1FZNjh2emMvd0Z1TitEaS9jTWdz?=
 =?utf-8?B?NXdPTHF2ZVF5V2VaeUNET3RYemNQZUJGbGFnN3A4OVMrUnBteHRubEtqNzJ4?=
 =?utf-8?B?VG9aV3FDMFdpTU9Ga2JCRTBLZGhnL2tBdmFkMGZjQVNqUE05NmY5SDZTN1hq?=
 =?utf-8?B?eHNhQ0hybjVDTzVRcHdsM0JxQUVLMGVzY2VGNVBhNlVkOS9taWFvQzJyOS83?=
 =?utf-8?B?M0F0R0ZyV29RdjVqV3FDdVdZb1Y3dGsrd05qWis1eWlTdHAzaWluenNBd3FU?=
 =?utf-8?B?RXJVcCtSY3JYOXFsN1MvRFV2dkhEdDVOTCtLQUNVU2VEekVOQytQbEpLM3NG?=
 =?utf-8?B?Z01yTk1GeFhRNmJmUDFhOVg5U25CUmVkeEtqRkltQlZ4OWNDSkJzaXJkQzVF?=
 =?utf-8?B?T0lxT09RV0hBRlJuQXpHYjcvdmJLU1FaRUxsbjZvTTVxTjJEYVovYmJ3LzJO?=
 =?utf-8?B?YS84eDFSUGZOUXNSOCtERWZ2b1NKcTFEeHBxdGFGOVNlbmZjUjlQM3NGcy9n?=
 =?utf-8?B?VjFSc1Bua283WkZHQ1dxc2lYYzdEc2FCZEg5ZGZaYjVFRFI2R1d2dUd1MmRu?=
 =?utf-8?B?ZHdkeVdabWdsWElIZytxTFV3RFY1VTI4V0F2eXhmdzgvTWVxSGxRTzJSRUtj?=
 =?utf-8?B?eGZEU0NLM0dCd01CNC90aUhDUjZvMk9nNmFZeWtQbGcrZllqd1BrcjZwb0FS?=
 =?utf-8?B?NW52R2lUUnhkSW1neGs0Z2w4YlhLWFQwSjVkSTF3cEhrVlB6Z3RweExjUE5H?=
 =?utf-8?B?cCtwZDJWbThTQ0wyaGx3MmdFL1VITmxwZktsZ0l6dytmR3JiOC84NXFwd1J2?=
 =?utf-8?B?TWUxSVdNT3BrUWJESzdFRnU1WW02RU1rcSthV3NzU3V2WFdOY3VLanYvakFv?=
 =?utf-8?B?TWc5VmJMb0hqemhFQ2lzQT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf44f81-863d-40bf-6204-08db16b298ca
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 22:00:52.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2138

hi Robin,


I find this this pcie node in their hardware include, its status is 
disabled, there is iommus = <&smmu TEGRA_SID_PCIE5>;   and the pcie_ep 
is 0x141a0000, is this what you are refer to?


         pcie_ep@141a0000 {
                 compatible = "nvidia,tegra194-pcie-ep";
                 power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;

                 reg = <0x00 0x141a0000 0x0 0x00020000   /* appl 
registers (128K)      */
                        0x00 0x3a000000 0x0 0x00040000   /* 
configuration space (256K) */
                        0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg 
space (256K)  */
                        0x00 0x3a080000 0x0 0x00040000   /* DBI reg 
space (256K)       */
                        0x1c 0x00000000 0x4 0x00000000>; /* Address 
Space (16G)        */
                 reg-names = "appl", "config", "atu_dma", "dbi", 
"addr_space";

                 #address-cells = <3>;
                 #size-cells = <2>;

                 status = "disabled";

                 clocks = <&bpmp_clks TEGRA194_CLK_PEX1_CORE_5>;
                 clock-names = "core";

                 resets = <&bpmp_resets TEGRA194_RESET_PEX1_CORE_5_APB>,
                          <&bpmp_resets TEGRA194_RESET_PEX1_CORE_5>;
                 reset-names = "apb", "core";

                 interrupts = <0 53 0x04>;       /* controller interrupt */
                 interrupt-names = "intr";

                 pinctrl-names = "default";
                 pinctrl-0 = <&pex_rst_c5_in_state>, 
<&clkreq_c5_bi_dir_state>;

                 nvidia,max-speed = <4>;
                 nvidia,bar0-size = <0x100000>;  /* 1 MB */
                 nvidia,device-id = /bits/ 16 <0x1AD4>;
                 nvidia,controller-id = <&bpmp 0x5>;
                 num-lanes = <8>;
                 nvidia,tsa-config = <0x0200b004>;
                 nvidia,aux-clk-freq = <0x13>;
                 nvidia,aspm-cmrt = <0x3C>;
                 nvidia,aspm-pwr-on-t = <0x14>;
                 nvidia,aspm-l0s-entrance-latency = <0x3>;
                 nvidia,aspm-l1-entrance-latency = <0x5>;

                 nvidia,host1x = <&host1x>;

                 num-ib-windows = <2>;
                 num-ob-windows = <8>;

                 nvidia,margin-port-cap = <0x194>;
                 nvidia,margin-lane-cntrl = <0x198>;
                 nvidia,cfg-link-cap-l1sub = <0x1c4>;
                 nvidia,event-cntr-ctrl = <0x1d8>;
                 nvidia,event-cntr-data = <0x1dc>;

                 nvidia,dvfs-tbl = < 204000000 204000000 204000000  
408000000
                                                         204000000 
204000000 408000000  666000000
                                                         204000000 
408000000 666000000  1066000000
                                                         408000000 
666000000 1066000000 2133000000 >;

                 iommus = <&smmu TEGRA_SID_PCIE5>;
dma-coherent;
                 iommu-map = <0x0 &smmu TEGRA_SID_PCIE5 0x1000>;
                 iommu-map-mask = <0x0>;

#if TEGRA_IOMMU_DT_VERSION >= DT_VERSION_2
                 interconnects = <&mc TEGRA194_MEMORY_CLIENT_PCIE5R>,
                                 <&mc TEGRA194_MEMORY_CLIENT_PCIE5W>;
                 interconnect-names = "dma-mem", "dma-mem";
#endif

                 nvidia,bpmp = <&bpmp 5>;
                 nvidia,aspm-cmrt-us = <60>;
                 nvidia,aspm-pwr-on-t-us = <20>;
                 nvidia,aspm-l0s-entrance-latency-us = <3>;
};


Kind regards,

Martin

