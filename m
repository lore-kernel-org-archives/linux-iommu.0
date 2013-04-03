From: Stuart Yoder <b08248@gmail.com>
Subject: Re: RFC: vfio API changes needed for powerpc
Date: Wed, 3 Apr 2013 13:25:26 -0500
Message-ID: <CALRxmdChSoKHaPTTiKjntkrntKLSN6zn0Z7e_WYYx1cKwk-cUQ@mail.gmail.com>
References: <1364942646.24520.27@snotra>
	<1364958751.2882.209.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364958751.2882.209.camel@bling.home>
Sender: kvm-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Scott Wood <scottwood@freescale.com>, Wood Scott-B07421 <B07421@freescale.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Yoder Stuart-B08248 <B08248@freescale.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: iommu@lists.linux-foundation.org

>> >  Type1 is arbitrary.  It might as well be named "brown" and this one
>> > can be
>> > "blue".
>>
>> The difference is that "type1" seems to refer to hardware that can do
>> arbitrary 4K page mappings, possibly constrained by an aperture but
>> nothing else.  More than one IOMMU can reasonably fit that.  The odds
>> that another IOMMU would have exactly the same restrictions as PAMU
>> seem smaller in comparison.
>>
>> In any case, if you had to deal with some Intel-only quirk, would it
>> make sense to call it a "type1 attribute"?  I'm not advocating one way
>> or the other on whether an abstraction is viable here (though Stuart
>> seems to think it's "highly unlikely anything but a PAMU will comply"),
>> just that if it is to be abstracted rather than a hardware-specific
>> interface, we need to document what is and is not part of the
>> abstraction.  Otherwise a non-PAMU-specific user won't know what they
>> can rely on, and someone adding support for a new windowed IOMMU won't
>> know if theirs is close enough, or they need to introduce a "type3".
>
> So Alexey named the SPAPR IOMMU something related to spapr...
> surprisingly enough.  I'm fine with that.  If you think it's unique
> enough, name it something appropriately.  I haven't seen the code and
> don't know the architecture sufficiently to have an opinion.

The only reason I suggested "type 2" is that I thought that was the
convention...we would enumerate different iommus.   I think that
calling it "pamu" is better and more clear.

Stuart
