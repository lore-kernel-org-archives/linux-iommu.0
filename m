Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792691882;
	b=KNRUTeAglRc47U3HHKyZ9c5etnit19dmOi1KhGtD0dD/Sc6RqczhJi8tWzI96g7o+OZ3
	 92wwoWC7UkQgexF79d2qMGgA7UcWDj5+btww6tqHlAKbl0GS80TAXes4ss6jpVO/7a4Lb
	 0jZQ7zf64kifSzKDiVeTLMjjigd47PAuPnhROiunpIugepLt/enhtKpMkuU+9YARglKAU
	 w0wt3x/hL+T1jgYYyBGSlPq4dkbxKy2Nagd8/DSaaz0I3UwGbjTJVa7nuM0O0/d0xRwSG
	 RgdY/ZXyY1M/JruIs8CIAjmefmKU0dzmTuK8VxH7Nwz6/hBQcilAOsOYklZX/VuIYGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691882;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-exchange-messagesentrepresentingtype:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Al1YF6Q6y6xoEDHIM6UUhKBvJP6jwZPU2G8ULc9n3uk=;
	b=fy48U1bqLD/cyod4hAnTSeTdRba397SkqeSGvLIz20d40l9qnbQb77N5lSh63Vs2rlal
	 eHVixPfU5mP+M+icHnJBE2wFevnZWu2jBXgeH43LMjKFkrmv8wiwoXG8bvGre6uxuA5KB
	 paUw0bLP9Cm7U/LKwrZXrj0OoOPJ37kQDI0uoVG5OsP3WYGtHKs8dPPnPLeCcLDvH0Ccg
	 Hf6oeJgQXjBas0joETP8fS33q+Rf4kAk4TZcxvHRduXDgHuT7XjwJA4SowgQLTAs8SeGV
	 ogwfE5xTV+1h4mpJ40UF2+70zEeZmBkfhtVp2hMwIsJB8JUz526XluNSRrbtrOsPnjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=M1jcOnMS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.8
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012008.outbound.protection.outlook.com [52.103.14.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA5606A31B
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 17:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77FA5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=M1jcOnMS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql7wriKxEqxWbf5SRRoV+DGomtLn3LniMobEdLTp6VJUQVKwAfZt8QbRCL9eqh1QLa+womKnCC2mzM349mD3jLP12+lM9/ltQC3D5/TTS+r9bNIEBaHKDkCslrBSH74+N21BO59+kgfhnb7yHp2GmozOTnQn6XY/o2GTvmZgtZNnWF67cZ09N+oMLLZAXJMUv5uJEK8oHl2VKMPMyXyqQrWNLcAgSteV1gLXkVCuPQ8p8hZURDnH5xY9+i1eq7104MbdrFtxHol98hmRnwCXzO42dfVAm28wRH0/ZV2RXw2s1NzY6qoL8xzuMKPoru16MmTZO3EGxtdYy0sxslN+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al1YF6Q6y6xoEDHIM6UUhKBvJP6jwZPU2G8ULc9n3uk=;
 b=CLi0+AGBe+9O9jzAFJ0dGPGuTB0U9QTFJ6/Ic1klO1nTo/ge+IoXDQt7Omes+f2E1m8cDrFAF0pCiY+Bj+Rwtb7IQhdafIcFrvq8CDCoQpWCxqIFTCXVR32aWpQ2t2SQ7ZmZeESx5WF9vQvUhJMW7MOkySEljyiMrZK722Ih2xR3bORs9iTl30qDa80elGb4MeM6BkF0eyR52UXLkskIKAYnRcgQULCHRp/22RZRwKFY4oSkMvgy64mK8da0FEvtI44H+7Zvo4jAESFi4VBYPHJXSv2820MnkwdULqBVthrfq7gC1vpSp6GXKUSGlXyMjWOIJpKofbADIy+ZZtejew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al1YF6Q6y6xoEDHIM6UUhKBvJP6jwZPU2G8ULc9n3uk=;
 b=M1jcOnMSm7ezo1KCwHRui+NHEgXYMayebQYl3XXzX746/SdAOqUpIQDt1wSPhh2QZoXmZn8ey+gTHc7+V/kxzVJwNDR5rOuOR4SadY12J7+0VkKyj0ZwljHBfnVJHGTCkzM/HhiyeaxtTslooo+P05wr26X0sQ4q5xj5SQboL+yupCSuzmOKtapBzugY++Cxj+yJ6B5uTXu+bbBU6RZDAxZjpuzC6ckevcHWFR29JOd3IXCUWkqBzxNHkpg6ECKd8tjHpshanW53xAaBS8WdAbNmSm9OggT16RGaIj9cYBIGYAwyN8HK1gTg6g3hWGe4cyWhNnTFkVMITYRE7pwBdg==
Received: from RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM (2603:10d6:10:ba::14) by
 CPWP152MB4109.LAMP152.PROD.OUTLOOK.COM (2603:10d6:103:f9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.16; Thu, 22 Oct 2026 17:57:55 +0000
Received: from RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM
 ([fe80::f919:4e42:f4eb:ecc4]) by RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM
 ([fe80::f919:4e42:f4eb:ecc4%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 17:57:55 +0000
From: =?Windows-1252?Q?C=E9sar_Zapata?= <el_caesar@outlook.com>
To: "joro@8bytes.org" <joro@8bytes.org>
CC: "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG][AMD IOMMU][VFIO] IVMD exclusion ranges block GPU passthrough on
 ASUS GA403UI, reproduced on 7.4-rc0
Thread-Topic: [BUG][AMD IOMMU][VFIO] IVMD exclusion ranges block GPU
 passthrough on ASUS GA403UI, reproduced on 7.4-rc0
Thread-Index: AQHdYkwdalKASy9EAkqg+eUxSukTOLcJ19/V
Date: Thu, 22 Oct 2026 17:57:54 +0000
Message-ID:
 <RO2P152MB51051CB0D23C926C671EAC708D652@RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM>
References:
 <RO2P152MB51059B868259A82B182943F48D652@RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM>
In-Reply-To:
 <RO2P152MB51059B868259A82B182943F48D652@RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: RO2P152MB5105:EE_|CPWP152MB4109:EE_
x-ms-office365-filtering-correlation-id: 1e4dc19d-a015-4dea-9b2f-08df3065ffb9
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|24021099003|6050399003|24121999003|15030799006|22091999003|51005399006|15080799012|19110799012|8060799015|8062599012|41001999006|40105399003|1602099012|10035399007|26121999007|3430499035|19061999003|102099032|440099028|4302099013|3412199025;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?psfEcUnSole7IOoF2xP/43MUBAma9YqVay+rrVRYjBuZeX0EwSXRfWNX?=
 =?Windows-1252?Q?bVNzMAOkBsMWQEbi7ProzC8xhvu3y+bGKDeBZAc/Z1RgvK4UrWzhak2R?=
 =?Windows-1252?Q?YZOHx2vz+lI2ZZllgOZuJqpR8wlLu+nxcN9CscQo2vSoyA570HpbcPm0?=
 =?Windows-1252?Q?vQ/HDY4a1GrfiZHCJ72vJslHgyhVUKVtjjsX5+OpD2CHxeXUWdAPI7cR?=
 =?Windows-1252?Q?mQy+A4YPbqwH5hhs9Nxrw4Oh9+b6jXB2n6UzqzU/cUbK6rD5XQzs4OBK?=
 =?Windows-1252?Q?M72PvrPbZlCh78xyIQWCmBw3WqDm7Q9+5csRY7CZ/RxSBOFETFQH4tCi?=
 =?Windows-1252?Q?oexK3Rgqn3RnmWALr40A+6WOpHHl7fAo6wclD0CRUnZBVr71nx5mMA/J?=
 =?Windows-1252?Q?bOVpN2pTVLUOYbSuBGMywhnF2dPJ1ojGQzfUs7O4dSb+/ECmjFrvOMrs?=
 =?Windows-1252?Q?zgUVrlBzx4NyIWJGrO/PhI9PvVmcm7ZwQ1iSt7Uv8z1JwAVyeY799u2w?=
 =?Windows-1252?Q?yfHiyj2KcbJ1IffvGhx4EMlTo7qo1xoajxHffyOtmkEZD7c49eVrR3fT?=
 =?Windows-1252?Q?0gX2fhY+TPyx74Uc2CMq4kTtdSJba7pKV07CkTKpkKWjdJoeajAc1HmG?=
 =?Windows-1252?Q?ZRqt/jeyeRKDmKrc9c5EckrNPypUiOpAhuH4aqsxN/1cGaXNeR18DzEm?=
 =?Windows-1252?Q?fFWTKT5KbVJm6mYkXQZZVdQAvKgHU4S4EHRlmyZz2f+nupXXXr8pcKZB?=
 =?Windows-1252?Q?bJcgrdSX2QvfMced+ep3jneGn/iuIirgctZKep3P7czJAMLEztLml9Vc?=
 =?Windows-1252?Q?of5uJS07/9AYsOZ5ff2f4bshHjMsemhwC0voOc9R4vnTYiT8DQXJ1YbI?=
 =?Windows-1252?Q?wGG8IK5vHI2QmvtuvUs3BDfLKL020mCOWaQOdytIhuFSvl6MCeSpCV+s?=
 =?Windows-1252?Q?lQX6FJQDa0Z9zNSGNHmPbVc9BIXZavFSRZ6w3r4/6jjC4bFcW8/mnYjE?=
 =?Windows-1252?Q?j8ut+Joe+txO2iwlnIJA9QbAohsVjGSMjZkzyPyE5b4ArQqp/nKnqWwV?=
 =?Windows-1252?Q?dFUSu5s88Os1YW74DczEWILu8SlKEt55waGXQiPAmHRhGL7Kk3etLuef?=
 =?Windows-1252?Q?GOKXKKnb+6QFyN/sWxPIrGDo6KLwCSuUXqM3AlS5q6ubOJNsrOOz3jOe?=
 =?Windows-1252?Q?c42N5tDi7s8bWZ5Iy52alXhOfoVWJ8LzZoIed1flP1oiaiOYWXWD3J4U?=
 =?Windows-1252?Q?A+mvPLJ5M6zv2vO6VVs=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Loeh8s/L7fnHpBdgwz2nY1wP9WMtT5PV4pELxijP3rBctrGtReJDjjTj?=
 =?Windows-1252?Q?aVHibwH9OOmxPNZNPqxWnbkyOpxxYDi5r5N4ie5t7en3FNHi9P1D4iYX?=
 =?Windows-1252?Q?Np45INGZcuI2hcYV7UrYrSn4dBAFmIyUjVuBjiyFRvPEXW2LZwA10DlI?=
 =?Windows-1252?Q?fz11UYB3VnT8de1N1f16hZmdl46Jmc0s6Vi0pQP+UkHTY1gw3Sxne147?=
 =?Windows-1252?Q?WEejfXdYpwSWArLMplrSlaE+ekracDAeDv3O9rhDAqxX8uDJJXINzAqe?=
 =?Windows-1252?Q?h184LpWK7v8XMm3pmQx5TiSZEIfevs0eqZz2JnezhpyIgqj3YYroBcQr?=
 =?Windows-1252?Q?1oMAXJ1pIjnXUemtagwYq/5tU4LdIntR1qYXtvMH2WUbGzUZwbHbtgxO?=
 =?Windows-1252?Q?h0XsersZBH53MIW2DYQzVJ1O7ZZWVD83xpXuObv9RQTy+LPmP6kv9KHN?=
 =?Windows-1252?Q?28FkwYxFwoev63hLxLBvS4XnhsrD9iBkoHfVjHEyN4rAoDrxiWxg94jO?=
 =?Windows-1252?Q?b3xZaNYbRQ1h+wPU5+0CVlXQJthi7S7jMYRjW/VgVaVSxuGF9/OS+zHy?=
 =?Windows-1252?Q?P2YV1MjcKhRKRLsDvRV1EES/MPQw02OkYu6wbjUDR5qo1s6zlYQI90rj?=
 =?Windows-1252?Q?Jw2G3Q559mBgVRehyxgWfJER8IHw7fw4z17BpFPFebmf+2Emie/EDrQj?=
 =?Windows-1252?Q?WQJkiYrz8SrDNrrAK3wNxRxyNUpNSCINPON0kZmP3W3PQQrCWD5FUSP9?=
 =?Windows-1252?Q?qvOQ6wjvJD7n0ZEVSbAGxHgfsDMpUIq7Ont3aysvexo+kKkZldeE+UX1?=
 =?Windows-1252?Q?cTQJ1kIt03cdlUyo5RFSfC6XJFZCenll+XO6/OclNrwvzADg9M7pxM8a?=
 =?Windows-1252?Q?v5KqafkyeQ+0hlFzyaB8qqTBvrJrxC9ebu1LNSWRHqfNSslDjHYiq8T5?=
 =?Windows-1252?Q?TGTKeyd6gBYlFcCRFUgm/jgxRtTMtNEx1kSFrLtYFLGcQdEV5fYemESP?=
 =?Windows-1252?Q?VGxV2yFtk3XJ8DRMa2Ild1ZjTedS9O29cD7mmrVHcDeXSoDkJeG6X8OL?=
 =?Windows-1252?Q?0mAAbUiDemdMlQfij/yx/cmzvtuADhr6rxOA6JKrbMj7rq3yzk+jIcdD?=
 =?Windows-1252?Q?SLWC4gAvACXlU3l5pUQS5eU2uTkKe/LqOLrOLFLeBKN40S10xGhNFi9/?=
 =?Windows-1252?Q?1yyUDkhaWx+pQGwHBbHBZBUC65wlmd7lEtWdceMXDLzxCorEf/hM64xt?=
 =?Windows-1252?Q?5gbmLwpuWSZs1B5gU+1+XPmcAIpzxif7ee5QJArmFF9FbUdFdJYe/xOJ?=
 =?Windows-1252?Q?ViNi9OfqgVxTb00yF5N8w9SYCSCZz+jWqM3AbR6yMXq5S5PC4mj0bC3f?=
 =?Windows-1252?Q?2dLWwjMiX1R+pw7yBQ3JfJa7xI3CmCNcz4wQHFApuO25KHZXyLAuaOFu?=
 =?Windows-1252?Q?r9J0czQhocOHw/hp2eSoWOy2dRAF2tv+k8h3/p3AxIdNRPuO6uQ19taa?=
 =?Windows-1252?Q?MO3ZTIsv?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: RO2P152MB5105.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4dc19d-a015-4dea-9b2f-08df3065ffb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 17:57:54.9799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPWP152MB4109

=A0=0A=
Hello,=0A=
I would like to report a reproducible AMD IOMMU/VFIO issue on an ASUS ROG Z=
ephyrus G14 GA403UI, now confirmed using an upstream Linux Mainline Vanilla=
 7.4.0-rc0 kernel without the proprietary NVIDIA driver.=0A=
=0A=
The firmware publishes broad IVMD exclusion ranges that Linux exposes as IO=
MMU_RESV_DIRECT. Consequently, VFIO refuses to establish an IOMMU domain fo=
r an otherwise isolated NVIDIA GPU.=0A=
=0A=
System information=0A=
System: ASUS ROG Zephyrus G14 GA403UI_GA403UI=0A=
CPU: AMD Ryzen 9 8945HS=0A=
BIOS: GA403UI.311, 06/09/2025=0A=
Distribution: Fedora 44 Workstation=0A=
Virtualization: QEMU/KVM with libvirt 12.0.0=0A=
AMD-Vi: Enabled and operational=0A=
=0A=
Kernels tested=0A=
Fedora 7.2.8-200.fc44.x86_64 =97 VFIO failure reproduced=0A=
Fedora 7.2.11-200.fc44.x86_64 =97 IOMMU_RESV_DIRECT persists=0A=
Stable Vanilla 7.3.0-363.vanilla.fc44.x86_64 =97 IOMMU_RESV_DIRECT persists=
=0A=
Mainline Vanilla 7.4.0-0.rc0.261022.7be4bc52.302.vanilla.fc44.x86_64 =97 VF=
IO failure fully reproduced=0A=
=0A=
The Mainline test used the in-tree nouveau driver, not the proprietary NVID=
IA driver.=0A=
=0A=
PCI devices and IOMMU group=0A=
The devices being assigned are:=0A=
0000:01:00.0 [10de:2860] NVIDIA AD106M / GeForce RTX 4070 Laptop GPU=0A=
0000:01:00.1 [10de:22bd] NVIDIA High Definition Audio Controller=0A=
Both functions are isolated in IOMMU group 14, with no unrelated devices.=
=0A=
The internal display is driven by the AMD iGPU (65:00.0), allowing the grap=
hical session to be stopped without disabling the host display hardware.=0A=
=0A=
Reserved regions=0A=
On Mainline 7.4.0-rc0:=0A=
$ cat /sys/kernel/iommu_groups/14/reserved_regions=0A=
=0A=
0x0000000097d36000 0x0000000097d37fff direct=0A=
0x00000000fee00000 0x00000000feefffff msi=0A=
0x000000fd00000000 0x000000ffffffffff reserved=0A=
The same direct region is exposed for many other IOMMU groups, including gr=
oups 0 through 17.=0A=
ACPI IVRS / IVMD=0A=
=0A=
The firmware IVRS table contains two IVMD type 0x22 entries with exclusion =
flag 0x08, covering requester IDs 0x0000=960x0fff.=0A=
Their memory ranges are:=0A=
0x97d36000=960x97d36fff=0A=
0x97d37000=960x97d37fff=0A=
Relevant raw IVRS bytes:=0A=
00C0: 48 00 00 00 22 01 00 01 22 08 20 00 00 00 FF 0F=0A=
00D0: 00 00 00 00 00 00 00 00 00 70 D3 97 00 00 00 00=0A=
00E0: 01 00 00 00 00 00 00 00 22 08 20 00 00 00 FF 0F=0A=
00F0: 00 00 00 00 00 00 00 00 00 60 D3 97 00 00 00 00=0A=
0100: 01 00 00 00 00 00 00 00=0A=
These exclusion entries appear to be responsible for the IOMMU_RESV_DIRECT =
region affecting the GPU.=0A=
=0A=
Reproduction on upstream Mainline 7.4.0-rc0=0A=
Boot the Mainline Vanilla kernel.=0A=
Confirm that 01:00.0 uses nouveau and 01:00.1 uses snd_hda_intel.=0A=
Connect to the host via SSH.=0A=
Stop GDM and verify that no users remain on the DRM devices.=0A=
Start an existing Windows 11 QEMU/KVM guest using both PCI functions with l=
ibvirt managed=3D'yes'.=0A=
The GPU is successfully rebound to vfio-pci during VM startup.=0A=
=0A=
However, VFIO reports:=0A=
vfio-pci 0000:01:00.0: Firmware has requested this device have a 1:1 IOMMU =
mapping, rejecting configuring the device without a 1:1 mapping. Contact yo=
ur platform vendor.=0A=
The VM fails to start.=0A=
Libvirt subsequently rolls back the assignment and restores:=0A=
01:00.0 -> nouveau=0A=
01:00.1 -> snd_hda_intel=0A=
=0A=
This demonstrates that PCI driver binding and unbinding work, but VFIO cann=
ot establish the required IOMMU domain.=0A=
=0A=
The same kernel error was previously reproduced on Fedora 7.2.8 with the pr=
oprietary NVIDIA driver, followed by successful rollback to the NVIDIA host=
 driver.=0A=
=0A=
No ACS override, allow_unsafe_interrupts, vfio-pci.ids=3D, IOMMU bypass par=
ameters, or local kernel patches were used.=0A=
=0A=
Related upstream work=0A=
This appears closely related to the AMD IOMMU IVMD handling series:=0A=
[PATCH v2 0/4] iommu/amd: IVMD handling cleanup and ivmd=3D boot override=
=0A=
https://lore.kernel.org/all/20260424092213.16976-1-suravee.suthikulpanit@am=
d.com/=0A=
=0A=
In particular, the proposed change to avoid converting IVMD exclusion regio=
ns into mandatory unity mappings appears relevant to this system.=0A=
=0A=
A separate test report from October 1, 2026, also describes broad IVMD excl=
usion ranges and their conversion from direct to reserved after applying th=
e v2 series:=0A=
https://lists.openwall.net/linux-kernel/2026/10/01/120=0A=
=0A=
I have not yet applied that patch series to this system, and I cannot confi=
rm whether it resolves the full VFIO assignment failure here.=0A=
Fedora bug report https://bugzilla.redhat.com/show_bug.cgi?id=3D2559096=0A=
The Fedora report has been updated with the full Mainline 7.4.0-rc0 reprodu=
ction and kernel log.=0A=
=0A=
Available diagnostic information=0A=
I can provide:=0A=
Complete ACPI IVRS table (ivrs.dat)=0A=
Decoded IVRS table (ivrs.dsl)=0A=
Complete kernel log from the Mainline 7.4.0-rc0 failure (attached)=0A=
lspci -nnk output=0A=
IOMMU group topology=0A=
Reserved regions from all groups=0A=
Relevant libvirt domain XML=0A=
=0A=
I am willing to test an updated AMD IOMMU patch series or a diagnostic kern=
el build, and report the resulting reserved regions, VFIO assignment behavi=
or, and host recovery.=0A=
=0A=
Could you confirm whether the current AMD IVMD handling work is expected to=
 address this case, or whether additional firmware/platform diagnostics wou=
ld be useful?=0A=
=0A=
Regards=0A=
=0A=
C=E9sar Z.=0A=
