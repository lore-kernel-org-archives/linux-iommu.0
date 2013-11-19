From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Report from 2013 ARM kernel summit
Date: Tue, 19 Nov 2013 17:35:24 +0000
Message-ID: <20131119173524.GK11778@mudshark.cambridge.arm.com>
References: <20131111.114723.1885845500744256130.hdoyu@nvidia.com>
 <20131115070627.6CF65C4079B@trevor.secretlab.ca>
 <20131119.114054.663999769447782808.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131119.114054.663999769447782808.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org" <ksummit-2013-discuss-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org>, "olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org" <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, "lwn-T1hC0tSOHrs@public.gmane.org" <lwn-T1hC0tSOHrs@public.gmane.org>, "paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org" <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, "khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 19, 2013 at 09:40:54AM +0000, Hiroshi Doyu wrote:
> Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote @ Fri, 15 Nov 2013 08:06:27 +0100:
> > On Mon, 11 Nov 2013 10:47:23 +0100, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> > > 1, When a device is populated, it checks if that device is IOMMU'able
> > >    or not. This is identified by "#stream-id-cells" in DT. If
> > >    a device is normal(non IOMMU), a device is populated. If a device
> > >    is IOMMU'able, it continues to be checked.

[...]

> > > I'm not so sure if this dependecy on "#stream-id-cells" is acceptable
> > > or not, but I haven't any better idea right now.
> > 
> > It seems a little fragile to me too. I'd rather the IOMMU requirement be
> > described more explicitly.
> 
> I think that Will Deacon can do better than I.

I already commented briefly here:

  http://www.spinics.net/lists/devicetree/msg11513.html

basically deferring to DT people :)

Anyway, I'm happy to tighten up the IOMMU requirement description but
*not* at the expense of breaking what we currently have for the ARM SMMU,
which is being used by Calxeda.

Adding Andreas and Rob for input on potential binding additions to the SMMU.

Will
