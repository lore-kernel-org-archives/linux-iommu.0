Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3281A4E85
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725318182; cv=fail; b=P4yQva6NVPwUApfEB4JQMjeJks5L3TLyG4NeO26PwvZ8Wy+edJHAtSNSAfwtX7OuGZ6Dp6q4KpOVB3MGXwk6Jw7CftEMD6GvwcIEjA1WTqXozNlhjO++axgglYl/hwskjBX/cyq1KQ2bnOtPMB71fRBrUdO73LSeYtlY6lV9mDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725318182; c=relaxed/simple;
	bh=2MohmsBa1MliireeX1EFUkcwK4+HWBUtXC83Vi7M0jM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsZU6n54Vk6UrVNqq5oINoGF205AHZg1BFHcJIJH44QDCP1pGnI0iT/py5vzzpNs8gBZjy+5TxOzGDwzCdKzRsuNB+/uPnnPYY3Q1iMZYp5Y1D4z/KatpzsuUhmMf0ZBJAp6pz9IBoKMYBO6PkV6xH5+Fh9CdnBLSIZmujkHtYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HU2fJodv; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HU2fJodv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ukp4z9gk4oyqQ5A2MOCwxiWiahN+T0wEKCZrrfmEB09jrdQtcI1QN5filYtF3TtkosXvEutEZGZVx/1NTTFdXhUmb9kVYp1E98Ymf1d9SWk4uS6Yn70O8T4uoCbiGSixn4I7J42IGFrgeI0dPN8I7GnCTnyhKMS9NSMVKz80tqnBkm3C3mcgwQqTPHXrPufvdG+S5cHz+yDEjoxF6ZDx1icD65/Wuc6twPFwtBPLZYsqujAEhjtW3jN8UJO5AzefsOSQ8AmQB+4dlVI3Dz+4wnbJQWXsQh26ex44nz9xFYaz0gk3lb+u8GnZe4UBamZj07aUk1YH7G4efbORQLXqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIFeTN/whupIykTGS23hT9ILUXjUSabFCw821bbAFJA=;
 b=WSj8n3RZcN/eO1tYoMD2Z9hG+El7VRiplaBk06kEdBaFnLdv9iw/QB1w8Dcku4QQ9wg8ibxCLcV5/MnxnZSVpQqDkmy3Rr+VMCV6CJ33RV0IAfKbmNSVsBMONe6QYUWpq/d4H26Y+BYzcTc5H5xHI6Srs/oCOTn2DEEruOlAAZtXIrIFShpjY/LiN4z0yimNtDzo6JHfvEpjcXWuNVPpJcyYR9TVM5w124rOSDDWrptkTglJYf0HrjM2uNnhqJvILAtSrplAdIILIzPLQF2BqZ0ggmE6WgMXwh0Q3fIUcjtiiPYOGH+EHFoNjlqBohNttN+YYqNEDdN6h+9Ou7VwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIFeTN/whupIykTGS23hT9ILUXjUSabFCw821bbAFJA=;
 b=HU2fJodvUzu9DKLnEpTGZVuic6HuemnbvUynFewo1OGBTzVNu4CFBTlxWnt4HScFjcMMBLgzmNIEsDzFES2gAK/XJ0RNL8r9uujSZBykVFuGP4ue/qbm+lwVRJeDVWnDKniC5T1OxWfoVLjPaADFLWW/3oTXq8+IE3ALLwgOpwp2tUfaMHORYPmJnj00KNoSK1efbdbztU3gdidzn9ftvIySdWa/vR+wJ0FiymvvPGlucjCriwvIac0X9tAdIjM0DENXaB1I2V46rMBVZWDsVjQh8mA8ZJapiGVGAQVMh/uJzlK/ldF2y5JmbCWldzgruo7iSOkyv/3AaFa6M340QQ==
Received: from BN0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:408:e6::23)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 23:02:54 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::ba) by BN0PR03CA0018.outlook.office365.com
 (2603:10b6:408:e6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 23:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 23:02:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 2 Sep 2024
 16:02:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 2 Sep 2024
 16:02:46 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Sep 2024 16:02:45 -0700
Date: Mon, 2 Sep 2024 16:02:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZtZEFKnKasX6433r@Asurada-Nvidia>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-2-praan@google.com>
 <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
 <ZtEKMknbGaD9q170@google.com>
 <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
 <ZtV1-IL8AZu--jGp@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZtV1-IL8AZu--jGp@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: fdee7d8b-fb3a-4ea8-63ee-08dccba3607d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pGsehx/4WC8T7XArET0L6LReWo/POSZXtKyH9k4h9rEMUDWBJUky1cLUjPTm?=
 =?us-ascii?Q?bEJMoRrd7Z/mp1nQnA5hqTkzdlUodcrn6P8g08Uu5Tp6IIyC4ozHYyFic1E+?=
 =?us-ascii?Q?quSam8QcbJH1MAWV3yVHMym8b+UKT8VLo59RdrqVhm6A9EYYV1jseAYajcxk?=
 =?us-ascii?Q?qAJmdzqI/lFApETZs7zsSwRrYPYAVM09VGoDvFFfaS3YBzKW1Oo46IDn9cUX?=
 =?us-ascii?Q?bhe7JuUSC2XS4f277Oeju/Mb0su43xsCF8p71VgJvuQFtpPuW1dj9hkrpOnx?=
 =?us-ascii?Q?e6FqQmtPHDrS7zipov9O59I0quYaFV9rsXx+RISa0nsV5fhjiafY0jEWxwSD?=
 =?us-ascii?Q?sfMzD/JuGnPMfuRA2pCfc13PpJzDNRw7LWrELq0N7QiZ18/q8nQRbV51FPMG?=
 =?us-ascii?Q?uQOA4ccU66kNBLOoePUdXAbC0WXNBgQBx/lcGDRGAAj3i1mo+CBGFQoOD7Kr?=
 =?us-ascii?Q?oYdVsu+zioDfOShEt1KwuZACYmKW7OI9nMOBjCyNq1V4ND/uU/dPpcId7Q1J?=
 =?us-ascii?Q?JxZ0N4IH3LSzDWh5AiIEMATHVVXYsVrcCNjbt1yHUElZEQyWqeD/zr5l4gUO?=
 =?us-ascii?Q?fszhHLY42pspYjubtvEXk4qIuxzljVS4tWMT5IHSPs2pJmiGUAOzVYi3GARz?=
 =?us-ascii?Q?aMa7pYGSZIpCNOouXrKJ3mtJSLT+GlE1s+7xHx6MMu7TiCnTmW5N5Etm6/LU?=
 =?us-ascii?Q?mvxBnv70b7a6uYRN4myNYz/xK76AHNyTsdT8l+qy5t1ast0cDDTH0aplw7x4?=
 =?us-ascii?Q?l0W9g/nH9igZtJmOD+e//jKIrtf4Lkv87ZWKqhviwlC6lpCx/PvmNWpOGLQS?=
 =?us-ascii?Q?nBoj42XLZ+tSKApzzXCLY8FbvAnHMMmMpe1F2d14WrToaD7cAQdLEBXg0reM?=
 =?us-ascii?Q?xXdRZmebye60CuL69xU2YLGy5gK7Gu3sXxfwB+NskWD2fQDQDqvWMvwoUQnn?=
 =?us-ascii?Q?Xw6DI2KatRZ8uPqG3KOij+V3dQK9rzPD4b8xStLzFctMCYWpjELHEeeUIjXi?=
 =?us-ascii?Q?GXyZEoPck1w53/oI3Nl+hu/KS/f7UTX0xsvZJ0zvNKIs+0IQAElfLm+5R142?=
 =?us-ascii?Q?/fNvAlVWxOg4VawbbB2yzXWWeUObT1DoLHpG3rDV/L/kvt2kY4L1qkQ38yNz?=
 =?us-ascii?Q?qR3WSizLG3j6Q3QdptPdJ985xTfeyuvX5+zNPsjPNwQRIubYnnC1BFIVl6TW?=
 =?us-ascii?Q?uIrvW2Apx+rK2HGbVlOL4gkx8WD71i6FTHlYDL9A2M2G1+fiy0u7RfHeHQBh?=
 =?us-ascii?Q?YHiQX4Q5su/Rz6eXG9+mw9xEpnKraT9pLkWlCpWWjlaOFxxZetQv6IF7mSoT?=
 =?us-ascii?Q?rblcLv/ao+CGGBWiL0dV/+6WTBTBlzq//UuXZSxa0CLlgSkR7CK6tedo42cv?=
 =?us-ascii?Q?3CquXuWGpJpD1FVTN0psrU37CElqujl1kucj6JVUdIBcJZcET3Jw5nvud5rh?=
 =?us-ascii?Q?Fjic4WndBs5ue6wzr9J5m6slielpxN45?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 23:02:53.6674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdee7d8b-fb3a-4ea8-63ee-08dccba3607d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131

On Mon, Sep 02, 2024 at 08:23:20AM +0000, Pranjal Shrivastava wrote:

> On Thu, Aug 29, 2024 at 06:45:53PM -0700, Nicolin Chen wrote:
> > On Thu, Aug 29, 2024 at 11:54:26PM +0000, Pranjal Shrivastava wrote:
> >
> > > > > +static const char * const class_str[] = {
> > > > > +       [0] = "CD",
> > > > > +       [1] = "TTD",
> > > > > +       [2] = "IN",
> > > > > +       [3] = "RES",
> > > > > +};
> > > >
> > > > Unlike the event IDs, these class code names are still uneasy to
> > > > read. Though it'd result in a print-format change, yet could we
> > > > simply dump full strings instead?
> > > >
> > >
> > > By "full strings" do you mean "CD => CD Fetch" as mentioned in the spec?
> >
> > Yes.
> 
> Ack. So, just for confirmation we want the following 4 class strings:
> "CD Fetch"
> "Stage 1 translation table fetch"
> "Input address caused fault"
> "Reserved"
> 
> Right?

Yes. I know they are longer, but more readable. So, you might want
to arrange the output format to present them nicely.

> > > Also, the printing would become
> > > more complicated as we'd have to log different fields for different
> > > events. Additionally, I don't see that many unions being defined
> > > elsewhere in the kernel.
> >
> > OK. That's a fair point. I think we could have just one common
> > union for the "good stuff" fields. Then, if something isn't in
> > the common union, do a FIELD_GET(raw)?
> >
> 
> I'm not sure if I get this right, but are you suggesting something like:
> 
> +struct arm_smmu_event {
> +       union {
> +       u64 raw_evt[4];
> +       struct {
> +               /* "Good stuff" fields */
> +       };
> +};
> 
> and then based on the fault type we can use the "good stuff" or raw_evt?
> So, basically just add a union between raw_evt and the other fields to
> improve struct arm_smmu_event present in v2?

Yea, I attached a test code at the EOM for your reference. Please
feel free to drop fields if they aren't common enough, and confirm
those bits are correctly written too.

> > > > > +       mutex_lock(&smmu->streams_mutex);
> > > > > +       event->master = arm_smmu_find_master(smmu, event->sid);
> > > > > +       mutex_unlock(&smmu->streams_mutex);
> > > >
> > > > Same as I pointed out at the other patch, "master" is unprotected
> > > > after the unlock. It can unlikely-yet-still-possibly race against
> > > > arm_smmu_release_device.
> > > >
> > >
> > > Hmm.. are you suggesting that the `master` could've been removed by the
> > > arm_smmu_release_device while we access it in an event handler?
> > >
> > > As in, something like the following situation:
> > >
> > > 1. The evtq_thread gets scheduled
> > > 2. arm_smmu_release_device removes the `master` & its streams
> > > 3. In the `handle_evt` we dereference `master` which has been `kfree`ed
> > >    (also, we don't return -EINVAL like we ideally should)
> > >
> > > In that case, I think I should add back the `arm_smmu_find_master` to
> > > the `arm_smmu_handle_evt` along with the locks. Nice catch! :)
> >
> > Probably could lock the entire iteration, master pointer could
> > be then passed in safely between the helper functions.
> 
> I'm just wondering if that'd be too much to print the "master_name", I
> mean what if we simply save the master_name in `struct arm_smmu_event`?
> That way, we can keep the locking as is in `arm_smmu_handle_evt` and
> simply print the stored "master_name".
> 
> Note: I'm suggesting to store the entire string and not just the ptr
> returned by dev_name(master->dev)), something like:
> 
> `strcpy(event->master_name, dev_name(master->dev))`

I'd probably move the dump() call inside arm_smmu_handle_evt(), and
within the lock to avoid strcpy. And eventually it would be located
at "else { /* Unhandled events should be pinned */ ret = -EFAULT; }:
https://lore.kernel.org/linux-iommu/8b93be1d913f9e227748de2d07e8540ddc2372ab.1724777091.git.nicolinc@nvidia.com/

> > > > Actually, the "Fault", "Bad fetch", and "Bad smmu config" doesn't
> > > > feel very necessary, since we prints the event string already.
> > > >
> > >
> > > That makes sense, I'll remove those in a follow up patch.
> > > Although, I guess we should still say "fault" somewhere to hint folks
> > > without arm-smmu-v3 knowledge that the event wasn't normal operation.
> > >
> > > LMK what you think? I've had a few interactions where clients tend to
> > > ignore the current "event received" dump considering that to be a part
> > > of normal SMMU operation.
> >
> > Well, we could improve the event_str with human-readable ones:
> >       s/F_TRANSLATION/Translation\ Fault
> >
> 
> Yea, but I'd still want to see a "spec searchable" name for the fault.
> Maybe we can have "Unexpected event recieved:<spec_fault_name>" in the
> "title" string?

That looks good to me.

> > > Although, we can dump the raw event only in the `default` case, i.e.
> > > when we don't have a dumper function for that particular event ID but
> > > that might still avoid printing the IMPL_DEFINED fields in fetch faults
> >
> > Makes sense to me by having a different title for the default case.
> >
> 
> Ack, we can have a different title for the default case. However, on a
> second thought, I believe we should log the "raw" event in all cases,
> since we aren't printing all the fields anyway. For example, for
> F_TRANSLATION we don't print IMPL_DEF fields, NSIPA etc. It might be
> helpful to see the raw event even for the "non-default" cases.

That makes sense. I'd dump the raw dwords outside the switch-case,
i.e. in the common path.

> > That is fine, though should break the lines too. Maybe:
> >       dev_err(smmu->dev, "%s%s%s%s%s\n", title,
> >               strlen(addrs) ? "\n" : "", addrs,
> >               strlen(other) ? "\n" : "", other);
> > ?
> >
> 
> I'd like line-feeds too, but I'm unsure if that could cause dmesg log
> interruptions? I assume adding a "\n" flushes the console buffer, i.e.
> we might get interrupted logs (I maybe wrong here).

I think the console_lock is grabbed per printk call, not per "\n".

Thanks
Nicolin

-------------------------------------------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6c48b53fc2b8..6b1ca9379999 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1894,6 +1894,37 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
 	return ret;
 }
 
+union arm_smmu_event {
+	u64 evt[EVTQ_ENT_DWORDS];
+	struct {
+	/* Bit 0:63 */
+	u64 id : 8;
+	u64 _res0 : 3;
+	u64 ssv : 1;
+	u64 ssid : 20;
+	u64 sid : 32;
+	/* Bit 64:127 */
+	u64 stag : 16;
+	u64 _res1 : 15;
+	u64 stall : 1;
+	u64 _res2 : 1;
+	u64 pnu : 1;
+	u64 ind : 1;
+	u64 rnw : 1;
+	u64 _res3 : 2;
+	u64 nsipa : 1;
+	u64 s2 : 1;
+	u64 class : 2;
+	u64 _res4 : 6;
+	u64 impl_def : 16;
+	/* Bit 128:191 */
+	u64 addr1;
+	/* Bit 192:255 */
+	u64 addr2: 56;
+	u64 _res5: 8;
+	};
+};
+
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
 	int i, ret;
@@ -1902,20 +1933,27 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
-	u64 evt[EVTQ_ENT_DWORDS];
+	union arm_smmu_event event;
 
 	do {
-		while (!queue_remove_raw(q, evt)) {
-			u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
+		while (!queue_remove_raw(q, event.evt)) {
+			u8 id = FIELD_GET(EVTQ_0_ID, event.evt[0]);
 
-			ret = arm_smmu_handle_evt(smmu, evt);
+			ret = arm_smmu_handle_evt(smmu, event.evt);
 			if (!ret || !__ratelimit(&rs))
 				continue;
 
 			dev_info(smmu->dev, "event 0x%02x received:\n", id);
-			for (i = 0; i < ARRAY_SIZE(evt); ++i)
+			for (i = 0; i < ARRAY_SIZE(event.evt); ++i)
 				dev_info(smmu->dev, "\t0x%016llx\n",
-					 (unsigned long long)evt[i]);
+					 event.evt[i]);
+			dev_info(smmu->dev, "id=%d\n", event.id);
+			dev_info(smmu->dev, "sid=%x\n", event.sid);
+			dev_info(smmu->dev, "class=%d\n", event.class);
+			dev_info(smmu->dev, "s2=%d\n", event.s2);
+			dev_info(smmu->dev, "inputaddr=%llx\n", event.addr1);
+			dev_info(smmu->dev, "ipa=%llx\n",
+					(u64)event.addr2 & GENMASK(55, 12));
 
 			cond_resched();
 		}
