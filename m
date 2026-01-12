Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF198364058
	for <iommu@lists.linux.dev>; Mon, 12 Jan 2026 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234216; cv=fail; b=buX9jv6Ii5MTnIkKDvIswjbw+CWPpRfBZl7bx6WxY/sAXOqfDhVarNsrevMFAvSXIPdOKpEYzUGHxqcEXFU/gCYurfEgXjjptkLw4XeMirYHSo4SQkSExZsvicIFcgwaSw/iiORAi1ype8Fz9ErxCT8+dwaV8WX1tPRhLZacZTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234216; c=relaxed/simple;
	bh=bGHp+BH7OojW9bojpoQ7Uq3NTPOYWLp0Uv/0OjyzehE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TCodiQ6k8RcpbWtx311UjPMLuC4PdyXTxOU5biGt9TpPIVa/PnGDu94H/uVx7Ro6N6xHnn/tLavZqQhXG7IxJ8393+QdEkqc/FrKm95gYWx4Obv3yvk9nVoC61KoYDFr7CtDWq2fOJ2PikJl2L+oGVrGc2dopC4ZsHNiqREgtmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M83pTU6m; arc=fail smtp.client-ip=40.93.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M83pTU6m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItnkjsYM34Gn3KLuaKrbi4mSyMaZruJ4Xgl9Zwl662I+WXE0EnprfOa5J9usO+Z185nkFFMGQa1xTXwJSjp27ku2wj4xLUYn+2xznbhnKITvYdNmIG/wB/mhg6CWRdATDG182o2w0h+AC04jKHgLZQLSSOGVlVY/uJ+vGNPL9lk3fxIkjefrKtMxOYXfp0QnFA5HsubqzITBxBVW7B5+EXmzOVpyqaWl+ZSdA6jd8UwgD/jFjhafRaUfuY9gI/c7X3d35a+PVJnPp//mtdNelkMZCH0GYmwB9zaweHNby4UsicQyFgbfQKF4SoEOOV4xQBXmUHjm1vprXP/d4mrAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBjlVRxcpLREaOLaNSc8MBvHSw8cCZtQQzBOxqoPOUk=;
 b=uNpgj8pzAMVn7VF5QHQ0tKI+CRYHzpWIfw45YmSSmDd06tSmZZCGdgtp37BRT7PTe8bQKoLQpZJwuRycZgP1u1eCE09S63dZ3ADOyl3Hh3NYRGRThMIGATQWCN50ltDs0s0/WpnSqXjQIhe87ZMcGtDNrJ0zal2iYHWf4SN4PHNd2PibsI1ANdKt5kto03V02IYi7bi9DG6f3IwyPGXTJE/TZdfiZGkwfDPQdvy3Ys0EerqyLRoZxdzoLMSrSi/mGwXY+WKOsYbhK9Zrg7p5rrtPfOuMww/Qj46duCraz4v9qf2Ynn3jrFQQihL8hpmvEx/wrr8wEgv+Xi1WxeQH1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBjlVRxcpLREaOLaNSc8MBvHSw8cCZtQQzBOxqoPOUk=;
 b=M83pTU6mSIwjnXfHoSJZx2KLY4IejKu/X37IKIt91fHtuMloAakWDHYwZptma+zTHLs0mTMP4KRF6yDOp4doaUpZuyJYEh+UucPgwuYUIR86s5fx15Yf5gvRejOpQV6K6rMWRnqICPatXKo47mgWqkRKOQOwje+Y/e3eVTCXf3DqP3tqW19Mlqy3l+CEyoRXSG89CANMtLRKmi13WskumbhOiKLDSGUXk0stpVJKUxikNFv8A0tLcuvIKXxkkR9ao9m5Uz5sTF/kmVCYT9s3XH+4mI9aeo7HVPhWN1OaLg2twh8vt9kIwEMomZSgx9PLrq60WTuuNVFUQ3At+057SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA4PR12MB9809.namprd12.prod.outlook.com (2603:10b6:208:54f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 16:10:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 16:10:11 +0000
Date: Mon, 12 Jan 2026 12:10:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com, praan@google.com,
	xueshuai@linux.alibaba.com, smostafa@google.com
Subject: Re: [PATCH rc v5 1/4] iommu/arm-smmu-v3: Add update_safe bits to fix
 STE update sequence
Message-ID: <20260112161010.GC812923@nvidia.com>
References: <cover.1766093909.git.nicolinc@nvidia.com>
 <58f5af553fa7c3b5fd16f1eb13a81ae428f85678.1766093909.git.nicolinc@nvidia.com>
 <aV7OBrH-TDiGRblt@willie-the-truck>
 <20260108003646.GA537728@nvidia.com>
 <aWUY-f3kvM94z4qh@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWUY-f3kvM94z4qh@willie-the-truck>
X-ClientProxiedBy: BL0PR02CA0138.namprd02.prod.outlook.com
 (2603:10b6:208:35::43) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA4PR12MB9809:EE_
X-MS-Office365-Filtering-Correlation-Id: 22027cd2-0190-4291-9778-08de51f5101f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+uBcE1QDNMQtNOFoDWhHfQk5L1XDtprUd4WrA4euZmUpPScLfk0ZnOvw56I8?=
 =?us-ascii?Q?XMnlan1w6mBw1K+50AOombkTIKsnt4sZ71hfKgXM/It1D9bD32NmhocniY/y?=
 =?us-ascii?Q?HF0QnbNLB6xbJEQjZfH59p5d6j1bn78ZKEN26HOKKO3CVXUZasi6he+SxLqQ?=
 =?us-ascii?Q?MFHyqatbYmk1O8Mowg8NGfPZb3/cCNhVRvhG+/dMwm+jEorVV3FBzBRGJot5?=
 =?us-ascii?Q?BIB+JMOEUHwc9VcxKlLnLiA+ufBtyWxbu3zvb3MfDovIOj4svS/uwcPkbstm?=
 =?us-ascii?Q?8bUV5qt5ZoOctGvewuyg9rvhFaRTocB5czvv1sz0oWcWwbYE5L49KSbGbHXw?=
 =?us-ascii?Q?Qo6H2BZvQR7sHgodyIk2VARrdPdpIOSWnk9sun8z5Zw2Xj7LtyhfqwDjTZuD?=
 =?us-ascii?Q?GAewrgyCJSaqpuC3pp+NTnFdzd8Dniugvklvqc1uvtBxN/ihpS1A6xRQ/eG7?=
 =?us-ascii?Q?u/bn33CaEV6V8ATgRzFLNSK0nMB1WplpDnGe9+PrVPvyr2Py1T0xBMiy2XQQ?=
 =?us-ascii?Q?GYBdyXp5OWNz+8Sj8IoZDrJl1wjfx2ABnYE5Wd4VfWF95owq36xLCulP+dmC?=
 =?us-ascii?Q?cT3NMmazbOuiUr+y9dQ1/T/doE5D5jrWXIu98Eah2LezZ7TteK2cBiVl67TD?=
 =?us-ascii?Q?wbIioEgEyDl8kjGUd4pncn2JF1M4Udb3VlY8KbH/ewBKDtdLihTv9E2xWGRN?=
 =?us-ascii?Q?soOebVkl6F7bIIeY51Kw1uWgcaxhxb/v2Lh7uOGLBBDHSAE4a589MV5A9soU?=
 =?us-ascii?Q?CC3WoRDvnTW5wlB0N/mPqPPNcedO+ERXgkP9rneCcJAdLPGJ69wOw2XhdiqY?=
 =?us-ascii?Q?ELoVI4wrlJb2qLjaNQYoA1VgXKHmtWNwOEWZxN4lJe/6l0dCQ3GSXJTh9CML?=
 =?us-ascii?Q?nk65d3UDEaPpV67zsuNJqQ4Oc5FLezFm6amqpYJ/U7POK7GRw56qBB4yLy9v?=
 =?us-ascii?Q?PgKZkKJSfAzbpWjogJmhkdVVHni63MdzlJ3zxO9YSddZkmf+koRZD1mWnVkE?=
 =?us-ascii?Q?NypBXw7xBo+CQOrUDcAKDgykdLDTJ6yqWfeUBhxqZmuFPfsw5+8l8XllOc5Z?=
 =?us-ascii?Q?4TwEC6S0RP10Qcfe9+6pCXnPYnyBS4xgTRPLmBX0tCTXi3mFuItxAC8tnhVz?=
 =?us-ascii?Q?rZBo7IPHhdQWU/bXSy7DENh0AjRuEYLIGaczHITX7YJeSKyA7Ebt8AbMV0jp?=
 =?us-ascii?Q?aWn9J24UNZSpXuocKDbOgNIxDrMH296Xps17iqqBLm2zr67rlm5neQ10ID2e?=
 =?us-ascii?Q?tJ33BSecobkfEhSQmuWQhJ7+KiyKpPDF20v/cINJJ0Ac0ap+4xKKoO8ePC0o?=
 =?us-ascii?Q?BrTgrAdAi7m9+Hir9O7OH1Bnt5uorLDmsa4imJKqVUIuGhf7cbNbz6rpe2qd?=
 =?us-ascii?Q?VnTyRTthnXlFPoWAxZwIkPp+S8aoxxmErXE/bfkoKGqs6vid4Tpb0Wej8T32?=
 =?us-ascii?Q?Ben26+lyfEaz5+hnMpeJnVqLUsIlp+R+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?10BiGXmbiIDK/MwVeEJTszNwSMjQt37KABG4vCWg45GXgSXjdFY1utDJ5a0H?=
 =?us-ascii?Q?bNFU+SrNmK2mdoJ+qryNFGYuZXLi078H/IAFppRMi+DplfH+7NjUczL3qkES?=
 =?us-ascii?Q?xy+c8mluEIqqxUuFW+j++j77NTTo4dzwn7jU/TYK7SWs9VekKww48v+oIXhE?=
 =?us-ascii?Q?jugzMbKlfiX11aGUXOSKnJpkHD2wVfn8r9sfsVSEi148FEO7CQ8UUBG0wSL+?=
 =?us-ascii?Q?HCv/enBNRqfo4OcZ7dMGZnKJq0rG906gZ+DJ0qwMTm/Uq7Nifa20SK4mNrsN?=
 =?us-ascii?Q?K06y5ziVkeHHagn14VxiuR3GIgwBUdPIN0rUfEfqT2kWQB/A8UvGlCEPZmV/?=
 =?us-ascii?Q?l6Ap5P65RpNAonslKULryCOtl0cdYhAS7QXhCA+tHheLYb6yaOuZ0WU3LMwg?=
 =?us-ascii?Q?IhpqOBZNnp1D4wes7tJlgVZoFFWws0op72s/8iwXkeSRtnvjl8dnik4CnJCm?=
 =?us-ascii?Q?dgblsDVbKxlBH7MXQBkgoQHCpojH1UdA+iv1S3cSHBZrRVztanc8YuK4fiU4?=
 =?us-ascii?Q?a4qADVdrQPeRMPVkhV/AnWCOcg4/iho4QF5114qtVrIwRLrQt3cnvJfWZszl?=
 =?us-ascii?Q?OtOWF9p1920GcmTL7FyMlai9FPWX7L1EVTTBF1du7dSvDsBUQ/I/6ZgpINVp?=
 =?us-ascii?Q?NwmxFTV4YeikPxwRws6LJkftzAk8onImv44/lSn7TIEpqjTvfMvTFl8VVJmS?=
 =?us-ascii?Q?zdzMFUHoBgeIPqwE3QMu3YY1HM058rJBJa6QC6tKJaLY8rOjIPdXWTptFFJ1?=
 =?us-ascii?Q?1OYqY0XxewNVj0h/MPhjCEPilRnOm3QmxmxyVp4mJb1TdJ6KinLDDl9mm7o7?=
 =?us-ascii?Q?j4OLKY+haAJVc/43dhNEEJOrTkXqr0eGehuLeTwEXX9nBiZQfP9OlTvo1rgd?=
 =?us-ascii?Q?Sb3Xd2fSKbk3vB1U5FzM9fXUWpN/cH1NDDEzLYPaWnS/Gnw52tv/0+UDxUpU?=
 =?us-ascii?Q?4z0yvDNzce2BySe+REOLtYjBcK4UP5436md1K7ycuEhaEYpNm93Vj8lMJFvH?=
 =?us-ascii?Q?ij0a/VyGXAhZbg65XkELJRRmU0z0udf/lS/dWDD+1xryaqf4nMlZUhHtWmaF?=
 =?us-ascii?Q?gPxx2z3ciWhIyJQN2zS+zycaO3V2UJwy4cI7Sa4mWcljPPKDi/3gwq9P7SZA?=
 =?us-ascii?Q?gNlQEPOnKT5gAfMfAKnmcmcFgGfI+qgXt4Jl3fB4wNl8ciQ3icdDEJmDDu+u?=
 =?us-ascii?Q?5Jn/jQ8cFrajViI53pji9NZvnZiC8rTHbx+P0XVRWXuAQhex64+co1N/q2Uy?=
 =?us-ascii?Q?dl3IyAWW+JeFVGb/UgEhxUxyUHZNfGew/tGNNyn5EPFd+6TKgTfplZyNncyZ?=
 =?us-ascii?Q?+hWPw6ZEcoA3D58fjYX2D33eMtIUn/qI+E3GfcfviDq/o+fV+RSgipUSlCcs?=
 =?us-ascii?Q?jvsqmvDFXIll5Qs0LXhSy89LJdnBSbLiGHaF7xt8ixoTTorLYMhhLyDPUJVu?=
 =?us-ascii?Q?yrUe4ybj46rNzjY9eDc/U+UdjTjGdSvBpz1IS6jehHISJPfA9D1c1nFC7y5E?=
 =?us-ascii?Q?4BEYSjGmUxU8j+FBvmZWIp/UkoWcQXPDdZ+cCSJ6WLX0MqV33sO3ZjNGa8+o?=
 =?us-ascii?Q?Xab6CD/Fi3wEj8RUwTqoNYRVe60JWkDSGJ8S6jJEyM+6bnKIXHP11lHXZvnS?=
 =?us-ascii?Q?atTyIpWc1FRY7BO7b6rOR/MmCW39AmwbErWfEWT1BOlbnl5M/4iySGcnQxln?=
 =?us-ascii?Q?HQUQheCuX2t/inHiqrkI/IEs6BfhZVp0cm9ryVOtpb1BIBGP4VLO/9xlRCda?=
 =?us-ascii?Q?qMOtEuqLjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22027cd2-0190-4291-9778-08de51f5101f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 16:10:11.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRsplOmEvqkroMpgoHUnXP8us8GPGm7CSRTG9lOcln1dfikRAhJ2DqaFIR4r6Hr1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9809

On Mon, Jan 12, 2026 at 03:53:29PM +0000, Will Deacon wrote:
> On Wed, Jan 07, 2026 at 08:36:46PM -0400, Jason Gunthorpe wrote:
> > On Wed, Jan 07, 2026 at 09:20:06PM +0000, Will Deacon wrote:
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
> > > >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 18 ++++++++++---
> > > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 27 ++++++++++++++-----
> > > >  3 files changed, 37 insertions(+), 10 deletions(-)
> > > 
> > > Hmm. So this appears to ignore the safe bits entirely, whereas the
> > > rationale for the change is that going from {MEV,EATS} disabled to
> > > enabled is safe (which I agree with). 
> > 
> > The argument was it doesn't matter for either direction be it disabled
> > to enabled or vice versa, see my reply to Mustfa in the v4 posting:
> > 
> > https://lore.kernel.org/all/20251218180129.GA254720@nvidia.com/
> 
> It would be good to include some of that rationale in the comment and
> commit message for patch 3, as at the moment it only talks about the
> change in one direction.

Sure, I can help Nicolin with that.

> I'm also still not convinced that this is generally safe, even if it
> works within what Linux currently does. For example, if somebody tries
> to disable S2S and enable ATS at the same time, couldn't you transiently
> get an illegal STE?

I would argue that the driver will never concurrently support S2S and
ATS together for the same device, it doesn't make sense as far as I
can understand.

You are correct that there is an illegal STE issue here in this case.

However, keep in mind, if there is concurrent DMA while the driver is
trying to do such a thing there must be a STE error, and we should try
to make it be a non-valid STE error.

Still, it seems easy enough to improve, do not add EATS to the safe
bits if either the current or new STE has S2S set. That will force a
V=0 and avoid the illegal STE. Nicolin?

Thanks,
Jason
