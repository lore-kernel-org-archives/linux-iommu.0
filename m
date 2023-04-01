Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4D17C7
	for <iommu@lists.linux.dev>; Sat,  1 Apr 2023 04:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680322671; x=1711858671;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NaYdy4aQKGVOogZ8IneqHSo7v+x6J3MWefEfDFLmml4=;
  b=e9Df6IdVCYma7n1GUrY3NgwNrH39n1Ik7TfunDsoIo2p1buQpYB8V8Rm
   kobw46Eff8e3OdIuxWIUIpzJ+0fl6/0f9pH4VMmenDp6n3JheXzqe1WQL
   RZDmtkqURwWcpUfU7PFJ8JA6yx7AjYEZjL+i+E7+fc/H2t2CyRvAwe7Vx
   k/7/C7sUhmtBSmpX57xmCTVhYZsfpHHov+s31PuErKfjgACjVvk/D1/c3
   88FBxvdiPtwu1jN9DF30MklyODRkl8RieL1XwsLflCUnDhujcaPbI1x4d
   Q/5VkXLSW6nt/68rREnUt8ulWmlqyKCz0ybOhcdj+D2kmhyC92AQDXLun
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="406651714"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="406651714"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 21:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="715671516"
X-IronPort-AV: E=Sophos;i="5.98,308,1673942400"; 
   d="scan'208";a="715671516"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 31 Mar 2023 21:17:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 21:17:50 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 21:17:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 21:17:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 21:17:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4DHiAowtHOLJeXV1nAGl3FOf1ZNNwHd4FFQjAG5LA9bU0h8ixfFKTTiOp8CDbMdnIp7n/HhreWfRncGMstQ4cVjS4p1nxV2SBLx7QC/Orb6rr7vfjH3WwbtaI7GVWf9/grjvI4P8xO4ns0oTq0FLyFCEOd+GHyO52H79vUKEE54vfUp9VHTY3n1pK9bRBW6h+QhrfOeCkU2jGSd+04BNffUmeQdkJffpxrG8gIYbpzk6jibf+UnqOX3GWxdKpfsDHqm/jUyVvDtY12YtaUkEvIhaxLW5mHuG0dfk15P7n+DK/GLXx4Dt4EOyZKRpX/SKiZBg/tdBhog1HfQ+X2sVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FursM09piQ1UhQG6zlSI17iGq+IPDeg8CsKAh2A7Sxs=;
 b=jJTOWbjz2zyPBSaWHFmp2MU5YDQI3g9sXCQ1ODQ/5gXwsDJHH21LxVYx2opgL0BDSxWpHejPzhGQ//lRnlVroLW4hdG0sFBROlm91NbAfSyZ3SYwZBuKtGm7HEKJpgP1XgB2KByBEiVzoshLfalIvUpBlfoRN7gfexLKRLxSMS41khLT9eBBTvYDma2/D1nFABC1th09TZTCQ2cIxGoC79w+hrxJWA460GCmwDThKwVjUAGaNFinFQGDPBiGx/7rakWa57oRQNdyxCK5NJMr7zj5ju15f55bZz/VxfxS5DbJvcnPbCBvSfUh20Mz/a/Ju5uo1C7USoip4wE7vCPbjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ0PR11MB6765.namprd11.prod.outlook.com (2603:10b6:a03:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Sat, 1 Apr
 2023 04:17:46 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6254.022; Sat, 1 Apr 2023
 04:17:46 +0000
Date: Sat, 1 Apr 2023 12:19:14 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<heng.su@intel.com>, <ying.huang@intel.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is "try_grab_folio" WARNING in
 v6.3-rc2 kernel
Message-ID: <ZCewwjLrswghvr3N@xpf.sh.intel.com>
References: <ZBExkEW/On0ue68q@xpf.sh.intel.com>
 <ZCbRCvQrzU8jdLlk@nvidia.com>
 <ZCb08lL4ISmEmanj@xpf.sh.intel.com>
 <ZCb9L77MUeBl5RzQ@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCb9L77MUeBl5RzQ@nvidia.com>
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ0PR11MB6765:EE_
X-MS-Office365-Filtering-Correlation-Id: d504d4b6-a33f-43f8-f1e4-08db32680bea
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKDQZI/x+2xdNaj+A4huwTpgSbcw6PuwHXkoTMz73014vDeCbq9IxXbmtlqOe6DB28EeL6IzhFhoWOos7HnrOMcA02DEWEAXSRD6dpFdcoypzdOHhcUt9JdgsJnWTHNe3xYZ5uFN4Zr2hHXqItTlBYSjATgp2b0HJfeU7wX8XfxNEakM4Id75GDbiPELCP6qnY8RBwJBEjmWCqbrItJPyw3u0bpwZskmrZIkj1ZlTrwmUMAyvvD03K3FXueotnKSqSD07R5uWAq8msMvx2SRJpkDbwMAZczBdxE/Bk2IHdqRddk4makSZ/5bvZEGMEQ0bvw/YXnPrCBC05XF0BTy1C6rFo2LSpbFSGbE4VxuQZwgIjUq2kTzETIJeNjwUTXbX/AU5HdtsTEKmhPuAoby+2is3uguhjFczrysgk7UdEf7H/G18BEZTw1JIGr6l/3ixKLBM34HhNyxO7Lu3tOTrACZ9vGapeCkNpXt1Z3UTCr7/Vuz7DhYp4McEflFMJ9fuF6GGsPJx5A8F2wH672Znze7Lu4NtM9C8QYw5d62H/rOCglE1/QYTyf4Bg1LEnB+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(6486002)(41300700001)(6666004)(26005)(82960400001)(38100700002)(83380400001)(186003)(44832011)(6506007)(86362001)(316002)(53546011)(6512007)(66556008)(107886003)(8936002)(478600001)(4744005)(2906002)(66946007)(4326008)(66476007)(6916009)(5660300002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NR35RzFe2vvIeKrQuN2da+Jgo8Gk3tfv642J0u7K42d0fNex2fcaY0OLteq5?=
 =?us-ascii?Q?wRmD9LaXuw4nNVkLXUjZUWlj9Gme+4x/7ihm9Owd71qmH0YqL3jeX7Iwzi9h?=
 =?us-ascii?Q?DyJ02E3oxLBgANvY8rS8wLwa1S6G3sNsbetWKEYbRT50P0XfAUCJPOX7lbFH?=
 =?us-ascii?Q?pjVqxKeD2d5wpVBshil5iJxAvYkCknw6LHlQbXtCv4Vm0US1yblMKjF3Dc7V?=
 =?us-ascii?Q?lEZ4Yu86kUl4/K4L+Q2SyJI2NpnCxO9uNqj2JkX+dlvooSS+S3/eL/IAHHpI?=
 =?us-ascii?Q?3i+PRCctoxurjOUX1rFiXxabn7chUnaGlwYTinZr17xuJNbLeF/0//SHlz23?=
 =?us-ascii?Q?AgN9/oyJfUlYAzL60QUO/b7aypz3JAydWPtTwo08SWknoKTcEYHnTnw2zzdw?=
 =?us-ascii?Q?4m8AGXB6k83o1AphB/x5U4Db+cWFZh0onYS4g6SZ/XGlnjiTpUo1QwKHNxCD?=
 =?us-ascii?Q?ek74jcMQ5xaMui60/953rETVTUNSHR1YoNsmrNGVfUyzid+LTxvg9y5CicL4?=
 =?us-ascii?Q?fP0KE9PcI9Jmx3iC+zPRIEuF/uzkD7f3pJBNTpx/OpOSfGc/AnrIDJTHXbNe?=
 =?us-ascii?Q?6GX3NIJE1A5Q7NPGpGnySb/66eIqs4f7PA5LIY/6zGcnmHEzXZD1EbCflT++?=
 =?us-ascii?Q?rmF4dOc/UeA57TC7HxEoyDcUXSfi2uLi5tsWfXTTDVLjleYQIEHmWBmbAwyc?=
 =?us-ascii?Q?W9oyogmKj6tNxHS9bBANhA4Ly7S21kPkxaI1GfRrzHpZwUcHQLVcv9gUGSzC?=
 =?us-ascii?Q?+Cs+PqnLXDfrZ3gyEzfyJoNYACdA0uxiWKRnI14rBowJ+MkWHfblCRbb/iK2?=
 =?us-ascii?Q?MqN1jmrs4W3vCPUcMlUlXnM+0PL8UOHkA17o56J9EU/TGaxI68h96Is3UYE9?=
 =?us-ascii?Q?CNBZ5Ns5EcF8C+nJBGWxN3wEMdVODHAk67zmNM+cwL7UCInbpzGZUG2Kjdt0?=
 =?us-ascii?Q?Ih3Q2xA362iQUSUaqc3EYAeXVJvqh3DahS1FTYfdaEooBPla48w44cTMbsdg?=
 =?us-ascii?Q?s0Z/prcaJvp+5PWmZdnRCR76TGmSb7wHRsGcF6KYzHnXLN9xpgib1n+nFzy3?=
 =?us-ascii?Q?gv8eITB4MalRm4ml66rQdB76jQDK/tCKpFlqDqo14DfMY5OtPs9G93Ooe+cF?=
 =?us-ascii?Q?V4+hrbOydFGBAuzA5lvHwUA2dE6xtR6X3Bt/OhAXLW4MyeRAsNQtJpDQtUA0?=
 =?us-ascii?Q?vMTEPKDzsBqvBY26+DtDLQCWrdFFA72bIT+a2PGbGIu7GQoSn8aDrwZTGs+0?=
 =?us-ascii?Q?gyYp19dNVxB1We8XJipAMhqaJu2S7KjLiLM506eHfqci8Lbqslk2tNUF93Ha?=
 =?us-ascii?Q?jHh5eYOwZcr4BRID2v73BPz3VFt8QxWtR22e2uNopl9eN2cr+gVKknW7PSfV?=
 =?us-ascii?Q?dmb+CYV+S/tMf/kznNELSGixIUV2CPxd6D/F9jFPU1esyXMMRlbf8DaQEUHE?=
 =?us-ascii?Q?HdE64hWAe9JR9mrlOaDiPKRgKSlm5NWs8z/s5MOmo1HxE4Y2PWOBGBdtJkF7?=
 =?us-ascii?Q?LjJX2flNgNyhVT6Aoh6wg87OLuO1eWIyNtc/9k3FQHxmxOxs1W1gV1gQqZhQ?=
 =?us-ascii?Q?knWZnQ7bUppdimWhDIjpWmGOBdC9r+HT+u+TILG+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d504d4b6-a33f-43f8-f1e4-08db32680bea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2023 04:17:46.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHuVFlytViU7lSHjfP+n2rL9zcMrLFs0hFoX6W7Elz4VDc9x/HDjpcyG+9zL2i+FzpO+yZPhsCU98rKSVMMIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6765
X-OriginatorOrg: intel.com

Hi Jason,

On 2023-03-31 at 12:33:03 -0300, Jason Gunthorpe wrote:
> On Fri, Mar 31, 2023 at 10:57:54PM +0800, Pengfei Xu wrote:
> >   Ah, seems to be related to platform independence, I can reproduce this
> >   problem on RPL-P platform vm in almost 3 seconds after executing bianry.
> 
> I think I found it anyhow
> 
> Please check the series I just sent against your reproduction for this
> 
  Great! Thanks for your fixed patch series!
  I will verify it soon.

  Thanks!
  BR.

> Thanks,
> Jason
