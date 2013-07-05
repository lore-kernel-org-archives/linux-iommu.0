From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 00/22] Unified SMMU driver among Tegra SoCs
Date: Fri, 5 Jul 2013 13:08:36 +0200
Message-ID: <20130705.140836.1744157186948281659.hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com><4999563.JlU6BysXQl@fb07-iapwap2.physik.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4999563.JlU6BysXQl-D3pzGp0ZKuDWZbiwp4sFPyrtisivX6KghOMvlBiLbJSELgA04lAiVw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "marvin24-Mmb7MZpHnFY@public.gmane.org" <marvin24-Mmb7MZpHnFY@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marc,

Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org> wrote @ Fri, 5 Jul 2013 13:03:58 +0200:

> Am Freitag, 5. Juli 2013, 13:44:35 schrieb Hiroshi Doyu:
> > Hi,
> > 
> > This series provides:
> > 
> > (1) Unified SMMU driver among Tegra SoCs
> 
> does this affect tegra2 in any way?

No, at all for Tegra 20.
This driver should work with Tegra 30, 114 and 148.
