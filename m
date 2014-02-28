From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/5] documentation/iommu: update description of ARM
	System MMU binding
Date: Fri, 28 Feb 2014 16:21:14 +0000
Message-ID: <20140228162114.GA30996@mudshark.cambridge.arm.com>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
	<1393002992-24561-4-git-send-email-will.deacon@arm.com>
	<CAOZdJXUfAygZqw9s5qOECLjyo=B0VaD29iesbWzDeMbbyVTgqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOZdJXUfAygZqw9s5qOECLjyo=B0VaD29iesbWzDeMbbyVTgqg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 28, 2014 at 04:17:43PM +0000, Timur Tabi wrote:
> On Fri, Feb 21, 2014 at 11:16 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> >
> > +- calxeda,smmu-secure-config-access : Enable proper handling of buggy
> > +                  implementations that always use secure access to
> > +                  SMMU configuration registers. In this case non-secure
> > +                 aliases of secure registers have to be used during
> > +                 SMMU configuration.
> 
> I'm confused.  Why does this property have a "calxeda" prefix?  How is
> it a Calxeda-specific property?

Because they wired up their SMMU backwards. It's basically an
implementation-specific erratum workaround.

Will
