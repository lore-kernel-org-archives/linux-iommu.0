Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795065557;
	b=xUnQUx2JZekTn2JvyWPeP1vPgCWjYrtuKRs5OX2CpAcaikTMGJZifyZeu2Q6WStRDhhJ
	 +J19aNoVU50iOpEQ/gSHce5ahlZnQUFvE14cViDz/n6EWIIPpdFGWFdsIlE8jL4VjNSV5
	 pA2fUPnr5slGnvS0FRxS5+0PRO911i7KNauFw0Bz+wXkv9P+djBhpDvzU8OfNxSOeXrRu
	 LHgG1Qkd9b/h/6DvuvXcKkf19nAQo6aQKyhjDr/D5L38y7g3N8BMne+J5gBrMJ0m/F3Mx
	 +U3eM4WjAKOBuswg9z3CEeGuRgHXPQfhBV4Yv7BlH1BFirhD22VyqEJf6Kjtde/N2aw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795065557;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UkVeQLurH/ci5rgcWGQy8fzwI1OSYv+J17CIboVfP9g=;
	b=SeZ5uwfCQjUKPVoST3AxVS1NKKev+SniucP63KmQcLcwElYsLQhWLlfeaKkCzA6wefX5
	 CxkaBM+gTi0wr8D8nxanjmSj0/JxnRYd7CpG9tfa2Qk0B6moyGE1Kxi5VJwsTO9GOHhc9
	 gIz9T4yProSrij/rPVBaDG6jYyJRqgnsU7N4VZ4Ytvgxm7wG0qWvgyD1UNDWy9DlAVRhP
	 4FwtnoiemwM3MzMpp/TDpDvKu+FOv60nV32MnIc2ZXEZY9BeCnVr0hZkL0TwByaW2ALOq
	 h67jTY3j9GApznR4cShTl9vuq/WgUcCyXXvT2H3VBWWfk6S3972uIwC/kc2ae735hAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=lzxW2tPz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.11.75
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012075.outbound.protection.outlook.com [52.103.11.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB4606A32A
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 05:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58EB4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=lzxW2tPz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx8iv3av9SeDirawron3kM8L042r7vSCvKVvwMTN0QILregRlDGCBcR8O47lgpTo/IJ+UZZOrJOwubSGY8FZD12krVLJdbC7GyZcQn2HV3V5MttPPhlQDZBXT1gbUeOUxNSnw2p6x0hQftoIJahhdGhhCuHfs9w6/RJf91WDTLYPyh2qV/uXwqJySQbhrLZVEy397pmvz+stX56+VX4xvlfB1yaJVleT6ba1ktDtaGW/IB8uNdq03tLt4XNulRL8RIthLkhlWBCtb25zsIN09KuSqht6mZOcog+BpvuDuYdW+WVUv/rVi3zPrjsk6zsIsD0vbHUfbbIdFhdLnNcT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkVeQLurH/ci5rgcWGQy8fzwI1OSYv+J17CIboVfP9g=;
 b=J5z79rlDHwVWz8PmNzq2CXvb/4oIKWetQ70bn2V2KBVzArl/REbaYWxteG6lEYBczu3E66c+fubmKWzDCVPDwSpvXaCsRucdPBgwU2Cpwmr1IEuj2q2VvSy9JssOL4mx5306ZAtpOXetWLocIUQ85rj48UF0zuZw4G8xezmbFOhu+5sScdFe/umOn0JOLDwSg931tNlhPTMb6iZSJ9VNyjJETQTlFzz0zeM3uFRxBAek/8D6Vf5Wtoi9ZD/zY1i5lyuDItFaaZ8bN6BToVv4yxA7osvAymjT9ou9VRx5jRSmJPIBUStjq9zSLCeeD7I2bj7rTdIU8twStitPcjYuog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkVeQLurH/ci5rgcWGQy8fzwI1OSYv+J17CIboVfP9g=;
 b=lzxW2tPzVQLfPWDFRE5TkMnUWXWCJDxg1p0f/Cz94hmwCs5PRzglf8WSovdlcH+z2rIjmDLt/nDj1rbtQ04jbvFHt6AWgNxRLFxaNoWGIku8GvB3gROGTLHoqMwePJCsHz5gByxkKwksGdl/W2u0jKlgkx7qEZyMVLMTmFR7qY69mc3NtjMl/+aR07GNCHwvUgD1EslCDGxeIWOAmlqEogKTgWOdJJtO+CTEY2LuT3MOfFY2zl5xLqWqR5iMusp0utaUeh4W/RUHvC4+F5VJ4SgQKZMRd9qlRmwg3DTeyIrxtO5S48HBoSpHpfMlCvbWWQoxlKwyjUJnKBr9EbBLlg==
Received: from PH7PR19MB6658.namprd19.prod.outlook.com (2603:10b6:510:1ac::6)
 by DS4PPF0323A2432.namprd19.prod.outlook.com (2603:10b6:f:fc00::a05) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 05:19:14 +0000
Received: from PH7PR19MB6658.namprd19.prod.outlook.com
 ([fe80::3d9d:46c2:d611:dc32]) by PH7PR19MB6658.namprd19.prod.outlook.com
 ([fe80::3d9d:46c2:d611:dc32%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 05:19:14 +0000
From: desobei <desobei@outlook.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	joerg.roedel@amd.com,
	jgg@ziepe.ca,
	jgg@nvidia.com,
	dan@reactivated.net,
	vasant.hegde@amd.com,
	kevin.tian@intel.com,
	Ankit.Soni@amd.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	guoren@kernel.org
Subject: Re: [PATCH v2] iommupt/kunit: Skip the page-table leak check on SMP
Date: Thu, 19 Nov 2026 00:19:04 -0500
Message-ID:
 <PH7PR19MB665864A8E20C7037DA13118EAF792@PH7PR19MB6658.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261031085536.18555-1-fangyu.yu@linux.alibaba.com>
References: <20261031085536.18555-1-fangyu.yu@linux.alibaba.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To PH7PR19MB6658.namprd19.prod.outlook.com
 (2603:10b6:510:1ac::6)
X-Microsoft-Original-Message-ID: <20261119051904.538-1-desobei@outlook.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR19MB6658:EE_|DS4PPF0323A2432:EE_
X-MS-Office365-Filtering-Correlation-Id: 95dd8754-7d37-49d5-5c6b-08df45fca689
X-MS-Exchange-SLBlob-MailProps:
	02NmSoc12Dcj/mAxI/NGvzdUkjNASRo/B6ZcXHJFUYi+ETN4pJsiTUoci6yV97r6E+rSi/qqfT9lQlu7UqTKtYN4QcDvVqgOqonrHMqwT/3k+lTm9ank8pij2g/5OaFKQraGWe1XjkQrpDpRKV5XWfqzbFXBWXll1Oz0cdc41jZikJ6fw70Bbp5sZ9s1GWXZaf3Y/cza0JjX0J2g+4x912wJA5DTNACmsHiwvhTCu/0A+jAze0mx7+Ye3UzMeuBXZxHiAsGnzGYwZgN4U44f3JWxRAPDO7WJB3FLRUDZC5NQBZn4eUjBl010PJugxvQ57WJro0TUU7MGFMwSdQpD7bDEiuJX9ve2UsHv7YrSTQ/M6ZSKPOUcuta+mI8g6GkdOPEuA63pr9H8VGbSGn8RodJYxswX4Re6vXYVuxf2vMlO8PZ+E9HCvjR+AJ7N3CYl7reDZrLC3CHQUHob0bkDiEabE5RlWNH2aRkpcPcfXdBBWYeHg3exczEGjpXHSCpSwjtqVPvMmxoiu8bkPlzg9XL+23VSdY34ipGsPMkInxiqK7ndb+ZruVfsp7SlVAI0Lj4l3zmsSlwFZF3DMJw1jbvibqm4qnpMx3O0B94ph9gfogwxdwqfsUTxP6BZQuhmNnDC2yFZw9Jgfifjxz0CAWQapiaDih1iRAu/bkAIll25955yaJtwCRJkxB+eZoPU2hA1Z0F5e3qBCNjU7fhDtoTrJMe8x81NmV4ozS9rX150WFfgRQ4UabLZDm0kA8L/
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|8060799015|24121999003|23021999003|6050399003|24021099003|12121999013|260925184616899003|15080799012|39105399006|5072599009|4140399003|22091999003|3412199025|440099028|3430499035|26121999007|18071099003|40105399003|41105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qylqEF8J7TSDV14dr+Swmz7h3qQEty/n0Kv8ip2pMtAvrExhAfVOEvyQhKvy?=
 =?us-ascii?Q?kqunzCEZ+HVSH3MNhwQq5m5pLClGXWwTJdtdBf7P9CBPirxGhvdCcyPaa5u2?=
 =?us-ascii?Q?8NP/+GnWabQaSnPy56PJOHr+22Pea/o/yniB1CJ/S0i5nHSNwfdLfTnL2IaR?=
 =?us-ascii?Q?txAUUgdG8MjWrtpmYh/83HGa7HuX3hQr48vhKILK5OKvk2ND9WyuY/otUSyk?=
 =?us-ascii?Q?fWgQWdEmxUe2IoZtfuSHhh3lpag28yzSn8CrJ8lfIDnPR6jbUwwdwA0/5M3j?=
 =?us-ascii?Q?cvYHI2/grPesBHtqR7/HC0HI4aZBWUSyMTjJf0oSVCUBfuXcbA1mUahOjuGw?=
 =?us-ascii?Q?2c/N6GtmtjMus7ddV9zqhAJI/OLc4rjLWSoGPbI2B+ptWc3xyN1KMVAAuW+U?=
 =?us-ascii?Q?LC9BNs+vRtQ+80jPHZoG5ZABQkoBzxOFZyLemRFm5E8vGejIdGZDGYWXspBP?=
 =?us-ascii?Q?G923c9+9oG1Yxp/2KoIL/T20nCxepHMzL4Lg9UgQs7nXTgd6cChZbB82mkXl?=
 =?us-ascii?Q?0Mx8LTI0on+mAmTm42EX/juK14F3Qs9Uu36h9R+nn8mh204ECp+BCv4Th/RK?=
 =?us-ascii?Q?NH+ByE02BFPmNjKap0NloXI1d9S2XX2cqhRHaSVrY9EmziCH6OFt47zOWdUX?=
 =?us-ascii?Q?K8qKHiW3i2hK5QUt9N85wxz9AOTZiiw3PsIr694zQ0lJrhA1/HTbMRpaKNyU?=
 =?us-ascii?Q?sE2598BqvEklEAbO9GE2MqGjJ1B+fPZdrc8STEa1rKNEDa5Ep6eBgYloVROX?=
 =?us-ascii?Q?AuwLmYAmxCg/0ok710xZWSa6rIxZFsReBTRNMkQATfsKbInDy7pWRb/GQcg6?=
 =?us-ascii?Q?B6rKBtyXjdvPJEAhKMKaKk+KHDGs/XJfoeJhIwhbNvQU5eweOhGykF9UdLbw?=
 =?us-ascii?Q?Nac0nEXFuZnVixLFNwBfBlIa/d/esB7PW7u1XUKZK6REKrEh/tzzuWYFuksQ?=
 =?us-ascii?Q?JZh0BcNc5Wdh9IhlozuCzBDltw3YACDxM+MO7osksA/lHPgl43Q7MeR65/wm?=
 =?us-ascii?Q?Ubk8GGJwOeN3nTPLShAUMq2zvUuDDsKe+m9/HVX1/5+hdMl4dVofiq97AYL8?=
 =?us-ascii?Q?XZHyfATMBV5hjj2wD2o6WITKLFg1LlzmDlYW651HUhIYa91G2YAXDLvBSrM8?=
 =?us-ascii?Q?lQlfOh6xkuff?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iq3iAHfj/Y7+t/yQTwsm7eXRfTXHdK6Bbr3YT6qKxi86Zi8qyZYanV0Ti9lM?=
 =?us-ascii?Q?p5RDTPabuEOjVUeYs1OgbmTciWa6vcyyDWcl7a+7w1148G88hhF5LhT+nIfk?=
 =?us-ascii?Q?ri1WuEwV4mW5ftUK3X9ZIHRZXghtqMIAGc6XMx8tBTs0GYds7R2d5LuKEVFD?=
 =?us-ascii?Q?73WMVSMTemz2VCZbUGgajspxDvmcIzBYJ7P2CU7iW2aFy/B6kFYrpmz2waYU?=
 =?us-ascii?Q?1pozyCDEp4RpObIH03lsLmYw4OQNXvza69gYETicKIeZwDmmJ3i4pqLLtFWd?=
 =?us-ascii?Q?+YJxe1UP31qTKJtyLmzRWlN0MrufTpdj/TOY7GuyYWqQEjmWM6SrbkPzQKyN?=
 =?us-ascii?Q?YoNBL2oLadaQytFg5OpkFictGHYWW01SqTx/Itdysjq2ghhFd22vY4KsflVW?=
 =?us-ascii?Q?+Qd33w/thKhCA1s6otQxgo3zEQOvV/3Mbabg7VyZ/Sd8hpS45upCS3soMRWh?=
 =?us-ascii?Q?0HdaHQvBvifD1MWhHAvchGAaKAT50yH45kLYnYLfualbaA2bPmHYbCmQL5uX?=
 =?us-ascii?Q?6WURtOaTRkLKPLt92LMPwWFuQvu7rCjqmVGxjEZ5snISJGkD559444ag1A2C?=
 =?us-ascii?Q?mu9IpH2bHTPb42rGwDWYWefvCca/KAyvcULgxzuuY8Rxi9pEujBTP7GtUQuq?=
 =?us-ascii?Q?hslMqrZ2509oVtBnH3Bpo+zh17Zn+hBPrVCWyHizQatsmMRRiKNKgLjmMcK4?=
 =?us-ascii?Q?hyM/43IPXkI2qFMwwtsEZR2oqDJMk/b7HolvKz4NFxvqqWwPf+Ge1pieLZas?=
 =?us-ascii?Q?3ZOaBuU13A5WTwhn+OZ/e1aYm/rV3DBJUyD4+Oj2hnYg423pGfzqnDI5XtTM?=
 =?us-ascii?Q?jGa9BJvGzrrkC4As1dDi5gRlvPWqHnyV9Sw/UkmjXlK9YX/bj579JYRPiPtV?=
 =?us-ascii?Q?wt03qLWdGCMdModsz/CkcinLRosPQbZqWLxInPUwj9hM4MdTf3lHFE1PZu57?=
 =?us-ascii?Q?L468XW1x15C89PaBpkJxLg8O+os0s8/uygqv3mOWPLGfO4D3a6lMJTf2fsYl?=
 =?us-ascii?Q?70/OK/4eLOufkR9zMODQL26+Vnn9hfl2as/cTboPs5S+Qi+avef5WqK8Yehx?=
 =?us-ascii?Q?019pHUO6Son9PclEMBYx/lV8DANNJBaarACVXDOYS0ODrpbHH+2XFSIiogFD?=
 =?us-ascii?Q?tWg8vV9NbqOqHnAVFOi8r+XL6XtztrWzAMipzZlxrDkQRCZn8QK1IrE7hu1S?=
 =?us-ascii?Q?XII0s8Y0ZOFKq2PqFw8yfjTZnCC5Pv5C70U0gRIU6YnYiTRZf2bIM47/mJjR?=
 =?us-ascii?Q?PVNT+5z8IsJ1Vt97hKYPpGbAaY4V4pcwVpzE5ArhCLMHL6p9YdLJv9fORWOp?=
 =?us-ascii?Q?2Dnl7+ub98WImLBPv4tnyv1pjGhnBpeyqjBrnFraPGFDKkwNx4BNucN7DDOW?=
 =?us-ascii?Q?vPbnYtBJBjp9vVYoEnMaZJq2AcqG?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95dd8754-7d37-49d5-5c6b-08df45fca689
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB6658.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 05:19:14.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0323A2432

On Sat, Oct 31, 2026 at 04:55:36PM +0800, fangyu.yu@linux.alibaba.com wrote:
> NR_SECONDARY_PAGETABLE is batched per-CPU on SMP, so the global counter
> can change as pending updates are folded, even when a test has freed all
> its page tables. Comparing the global counter before and after a test
> can therefore report a false leak. A failed teardown assertion also
> aborts cleanup, causing subsequent tests to fail because the test driver
> is still registered.

I hit this independently on next-20261117, with the KUnit tests built
in and booted in x86_64 QEMU/KVM guests with KASAN, lockdep, UBSAN and
kmemleak enabled. The first false report aborted the cleanup, and every
later test case of the amdv1, vtdss and x86_64 iommu_test and fmt_test
suites then failed with "Driver 'pt_kunit_dev' is already registered".

With this patch applied, all six suites pass with 1 and 8 vCPUs, and
there are no KASAN, UBSAN or lockdep reports.

Tested-by: desobei <desobei@outlook.com>

>  	 * Look for memory leaks, assumes kunit is running isolated and nothing
>  	 * else is using secondary page tables.
>  	 */
> -	KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable,
> -			global_node_page_state(NR_SECONDARY_PAGETABLE));
> +	/* Per-CPU vmstat batching can cause false leak reports on SMP. */
> +	if (!IS_ENABLED(CONFIG_SMP))
> +		KUNIT_ASSERT_EQ(test, priv->orig_nr_secondary_pagetable,
> +				global_node_page_state(NR_SECONDARY_PAGETABLE));

A small follow-up thought, not a blocker: on !SMP this is still an
assertion in the exit handler, so a real leak there would again skip the
cleanup and break the suites that run afterwards. KUNIT_EXPECT_EQ()
would still fail the test case but let the cleanup finish. In my testing
on SMP, switching the original check to KUNIT_EXPECT_EQ() was enough to
stop the "already registered" failures.

I debugged this with the help of an AI coding assistant
(Claude Opus 5.5).
