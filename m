From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Report from 2013 ARM kernel summit
Date: Thu, 21 Nov 2013 11:00:24 +0000
Message-ID: <20131121110024.GA8395@mudshark.cambridge.arm.com>
References: <20131119.114054.663999769447782808.hdoyu@nvidia.com>
 <20131119173524.GK11778@mudshark.cambridge.arm.com>
 <528BCDCE.6070006@gmail.com>
 <20131120.083955.1386179068365424976.hdoyu@nvidia.com>
 <CAL_Jsq+AxEWhkOhxwAZ=+rpzDZ+yC1b3ZV541UhOu9kiwUhUdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+AxEWhkOhxwAZ=+rpzDZ+yC1b3ZV541UhOu9kiwUhUdQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "lwn-T1hC0tSOHrs@public.gmane.org" <lwn-T1hC0tSOHrs@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 20, 2013 at 08:02:10PM +0000, Rob Herring wrote:
> On Wed, Nov 20, 2013 at 12:39 AM, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> >   smmu_a: iommu@xxxxxxxx {
> >         #iommu-cells = <2>;
> >         ....
> >   };
> >
> >   smmu_b: iommu@xxxxxxxx {
> >         #iommu-cells = <3>;
> >         ....
> >   };
> >
> >   device_a {
> >          iommus = <&smmu_a param1 param2>,
> >                   <&smmu_b param1 param2 param3>;
> >   };
> >
> > This can describe the relation between a device and an iommu
> > independently. The number of params needed for each IOMMU can be
> > sepcified by #iommu-cells in its iommu entry.
> >
> >   device_a <-> smmu_a, needs 2 params for a device
> >   device_a <-> smmu_b, needs 3 params for a device
> >
> > For example, "smmu_a" can be an bus level global IOMMU where all child
> > devices can be an master of "smmu_a", and "smmu_b" is a local IOMMU
> > only for "device_a".
> >
> > "memory controller"---"smmu_a"---bus--+--"smmu_b"--"device_a"
> >                                       |
> >                                       |
> >                                       +--"device_b"
> 
> I think the above binding would be the correct way to describe things
> if you have 1 device connected to 2 IOMMUs (directly rather than
> chained). IIUC, that is something you have on tegra?
> 
> For the topology above where you are chaining iommu's, I think
> something like this is more accurately describing the hierarchy:
> 
>   smmu_b: iommu@xxxxxxxx {
>         #iommu-cells = <3>;
>          iommus = <&smmu_a param1 param2>;
>        ....
>   };
>   device_a {
>          iommus = <&smmu_b param1 param2 param3>;
>   };
> 
> I remember discussing this with Will and seem to recall some issue
> with describing things this way. But looking at it now, I don't see
> what that was.

I think it was the usual issue with StreamID remastering. For example, if
you had a device going into two chained IOMMUs, you need a way to relate the
StreamIDs of the device to the remastered IDs coming out of the first SMMU.

Will
