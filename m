From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC PATCH 4/7] iommu: provide helper function to configure an
	IOMMU for an of master
Date: Mon, 01 Sep 2014 16:46:18 +0200
Message-ID: <3729116.F0gWrQGFZl@wuerfel>
References: <1409327670-3495-1-git-send-email-will.deacon@arm.com>
	<1409327670-3495-5-git-send-email-will.deacon@arm.com>
	<20140901082939.GC24430@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140901082939.GC24430@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Monday 01 September 2014 10:29:40 Thierry Reding wrote:
> 
> I think this could use a bit more formalization. As I said in another
> reply earlier, there's very little standardization in the IOMMU API.
> That certainly gives us a lot of flexibility but it also has the
> downside that it's difficult to handle these abstractions in the core,
> which is really what the core is all about, isn't it?
> 
> One method that worked really well for this in the past for other
> subsystems is to allow drivers to specify an .of_xlate() function that
> takes the controller device and a struct of_phandle_args. It is that
> function's responsibility to take the information in an of_phandle_args
> structure and use that to create some subsystem specific handle that
> represents this information in a way that it can readily be used.

Yes, good idea.

> So I think it would really be helpful if IOMMU gained support for
> something similar. We could create a struct iommu to represent an
> instance of an IOMMU. IOMMU drivers can embed this structure and add
> device-specific fields that they need. That way we can easily pass
> around instances and upcast in the driver in a type-safe way.

Right.

> At the same time, a struct iommu_master could provide the basis to
> represent a single master interface on an IOMMU. Drivers can again embed
> that in driver-specific structures with additional fields required for
> the particular IOMMU implementation. .of_xlate() could return such an
> IOMMU master for the core to use.

I'm not convinced it's necessary. Could this just be a 'struct device'
instead of 'struct iommu_master'?

> With such structures in place we should be able to eliminate many of the
> loops in IOMMU drivers that serve no other purpose than to find the
> master context from a struct device * and some parameters. It will also
> allow us to keep a central registry of IOMMUs and masters rather than
> duplicating that in every driver.

Yes, we should be able to identify an iommu context in a generic way,
but why do you want to break it down to individual masters within
one context?

	Arnd
