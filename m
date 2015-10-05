From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [RFC PATCH v5 0/3] vfio: platform: return device properties for
 a platform device
Date: Mon, 5 Oct 2015 11:53:25 +0200
Message-ID: <20151005095325.GG9011@cbox>
References: <1443604077-3155-1-git-send-email-b.reynal@virtualopensystems.com>
 <1443814099.26107.124.camel@redhat.com>
 <20151002202844.GD32011@cbox>
 <CAFEAcA84seKfSh94XFJZxBeBzRd=twj2QaFvjMeDKYhrWQu7Nw@mail.gmail.com>
 <CAN9JPjF+gYJaxm1kO5c4Swps4TDKrHxJ3v-NP2D_YzEghkn1DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <CAN9JPjF+gYJaxm1kO5c4Swps4TDKrHxJ3v-NP2D_YzEghkn1DA@mail.gmail.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Baptiste Reynal <b.reynal@virtualopensystems.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "tech@virtualopensystems.com" <tech@virtualopensystems.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
List-Id: iommu@lists.linux-foundation.org

[why are you top-posting?]

On Mon, Oct 05, 2015 at 11:42:38AM +0200, Baptiste Reynal wrote:
> In this patch series we want to wrap an already available kernel
> interface to expose a device property to userspace, 

which 'already available kernel interface' is that exactly?

> in order to keep
> the code lighter on the userspace. We need those properties in VFIO as

I'm not sure I agree with your 'need those properties in VFIO' statement
here, can you elaborate?

> VFIO grants the possibility to develop userspace drivers.
> 
> The sysfs doesn't seems to be ready for this kind of usage. We can
> only find raw data that require heavy parsing. Here we retrieve
> directly usable data and it can be extended later according to new
> needs (as it is already done with ACPI).

Why couldn't you expose this kind of data through sysfs instead of VFIO
and independently of VFIO?  Would that be more wrong/difficult/whatever?

> 
> This interface has been developed for VFIO and is currently bound to
> it, though there is no special dependencies with it. We could make it
> more generic, but I can only think of VFIO to use it.

Thanks,
-Christoffer
