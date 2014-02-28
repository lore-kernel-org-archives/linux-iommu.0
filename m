From: Timur Tabi <timur-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 3/5] documentation/iommu: update description of ARM System
	MMU binding
Date: Fri, 28 Feb 2014 11:07:31 -0600
Message-ID: <5310C253.40804@codeaurora.org>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
	<1393002992-24561-4-git-send-email-will.deacon@arm.com>
	<CAOZdJXUfAygZqw9s5qOECLjyo=B0VaD29iesbWzDeMbbyVTgqg@mail.gmail.com>
	<20140228162114.GA30996@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140228162114.GA30996-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 02/28/2014 10:21 AM, Will Deacon wrote:
>>> > >+- calxeda,smmu-secure-config-access : Enable proper handling of buggy
>>> > >+                  implementations that always use secure access to
>>> > >+                  SMMU configuration registers. In this case non-secure
>>> > >+                 aliases of secure registers have to be used during
>>> > >+                 SMMU configuration.
>> >
>> >I'm confused.  Why does this property have a "calxeda" prefix?  How is
>> >it a Calxeda-specific property?

> Because they wired up their SMMU backwards. It's basically an
> implementation-specific erratum workaround.

Hmmmm....

Other than making the same wiring mistake, is there any reason any other 
ARM chip would need this property set?

The reason I ask is that it's kinda weird (well, to me at least) that we 
have an property named for a specific SoC, but the implementation and 
documentation tries so hard to hide that fact.  I would think that the 
binding document would provide some explanation as to why the property 
has a "calxeda" prefix.
