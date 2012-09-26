From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: 3.6-rc7 boot crash + bisection
Date: Wed, 26 Sep 2012 17:04:07 +0200
Message-ID: <20120926150407.GD10549@amd.com>
References: <20120924210348.5f50677b@brain.lan>
 <1348597970.28860.114.camel@bling.home>
 <20120925205420.0a07dea2@brain.lan>
 <1348602226.28860.132.camel@bling.home>
 <20120926010154.49cc2588@brain.lan>
 <20120926144345.GC10549@amd.com>
 <1348671121.28860.186.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1348671121.28860.186.camel@bling.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Florian Dazinger <florian@dazinger.net>, linux-kernel@vger.kernel.org, iommu <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 26, 2012 at 08:52:01AM -0600, Alex Williamson wrote:
> Assuming this works, it may be ok as a 3.7 fix, but if there was
> actually more than one device behind the alias we'd expose them as
> separate iommu groups.  I don't think that's what we want.  Maybe it
> should at least get a pr_warn.  Thanks,

True, we need something more generic as the real fix. When Florian
reports success I'll try to get this still into 3.6, otherwise to
-stable.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
